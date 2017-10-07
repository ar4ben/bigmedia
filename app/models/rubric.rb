class Rubric < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :articles

  private

  def should_generate_new_friendly_id?
    slug.nil? || name_changed?
  end
end
