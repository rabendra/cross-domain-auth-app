class CategorySerializer < ActiveModel::Serializer
  attributes  :name,
              :user
  def user
    UserSerializer.new(object.user, root: false)
  end
  
end
