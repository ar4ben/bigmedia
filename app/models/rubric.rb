class Rubric < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :articles

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  private

  def should_generate_new_friendly_id?
    slug.nil? || name_changed?
  end
end
