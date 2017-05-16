class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  acts_as_taggable

  has_many :categorization
  has_many :categories, through: :categorization

  validate :has_category
  validates :title, :slug, presence: true

  private

  def has_category
    errors.add(:base, 'Должна быть выбрана категория') if self.categorization.blank?
  end

  def should_generate_new_friendly_id?
    slug.nil? || title_changed? 
  end
end
