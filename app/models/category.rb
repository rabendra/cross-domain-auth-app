class Category < ApplicationRecord
  has_many :categories_listings
  has_many :listings, :through => :categories_listings
  belongs_to :user, required: true
end