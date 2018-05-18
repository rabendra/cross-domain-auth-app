class LoginSerializer < ActiveModel::Serializer
  attributes :accessToken, :id, :created_at, :updated_at, :username, :email, :image_url

  def accessToken
    object.user_token
  end
end
