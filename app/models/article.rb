class Article < ActiveRecord::Base
  acts_as_taggable
  has_many :categorization
  has_many :categories, through: :categorization

  validate :has_category

  def has_category
    errors.add(:base, 'Должна быть выбрана категория') if self.categorization.blank?
  end
end
