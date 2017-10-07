class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  acts_as_taggable

  has_many :categorization
  has_many :categories, through: :categorization
  belongs_to :rubric

  validate :has_category?
  validates :title, :slug, presence: true, uniqueness: true
  validates :body, :preview_img, :lead, presence: true
  validates :tag_list, presence: true

  before_save :make_preview_img_src_relative
  before_save :set_published_at

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def should_generate_new_friendly_id?
    slug.nil? || title_changed?
  end

  def self.find_with_pagination(params = {})
    WillPaginate::Collection.create(params[:page].to_i < 1 ? 1 : params[:page], per_page_for_page(params[:page])) do |pager|
      result = Article.where(published: true).order('published_at desc').limit(pager.per_page).offset(offset_for_page(params[:page]))
      pager.replace result
      unless pager.total_entries
        pager.total_entries = self.count
      end
    end
  end

  def self.offset_for_page(page_number)
    page_number.to_i > 1 ? ((page_number.to_i - 2) * 19 + 18) : 0
  end

  def self.per_page_for_page(page_number)
    page_number.to_i > 1 ? 18 : 19
  end

  private

  def make_preview_img_src_relative
    self.preview_img = self.preview_img[/https?:\/\/.*?(\/.*)/,1] if self.preview_img =~ /http/
  end

  def has_category?
    errors.add(:base, 'Должна быть выбрана категория') if categorization.blank?
  end

  def set_published_at
    self.published_at = Time.now if self.published_changed? and self.published == true
  end

end
