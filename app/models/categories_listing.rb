class CategoriesListing < ApplicationRecord
  belongs_to :listing
  belongs_to :categories
end
