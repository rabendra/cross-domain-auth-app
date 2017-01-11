class Listing < ApplicationRecord
  belongs_to :user, required: true
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  has_many :categories_listings
  has_many :categories, :through => :categories_listings  # Edit :needs to be plural same as the has_many relationship   
end
