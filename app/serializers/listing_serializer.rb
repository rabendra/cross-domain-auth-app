class ListingSerializer < ActiveModel::Serializer
  attributes  :item_name,
              :location,
              :description,
              :price,
              :user
  has_many :categories_listings 
  has_many :tags, key: :tags do
    object.tag_list
  end

  def user
    UserSerializer.new(object.user, root: false)
  end

end