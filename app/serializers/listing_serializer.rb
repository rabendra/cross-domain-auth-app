class ListingSerializer < ActiveModel::Serializer
  attributes  :item_name,
              :location,
              :description,
              :price,
              :user

  has_many :tags, key: :tags do
    object.tag_list
  end
  has_many :categories, key: :categories do
    object.categories_listings
  end

  def user
    UserSerializer.new(object.user, root: false)
  end

end
