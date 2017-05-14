class Category < ActiveRecord::Base
  has_many :categorization
  has_many :articles, through: :categorization
end
