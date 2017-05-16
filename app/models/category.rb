class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :categorization
  has_many :articles, through: :categorization

  private

  def should_generate_new_friendly_id?
    slug.nil? || name_changed? 
  end
end
