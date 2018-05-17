
class UserSerializer < ActiveModel::Serializer
  attributes  :id,
              :email,
              :username,
              :created_at,
              :updated_at,
              :image_url,
              :provider

  attribute :user_token, if: :user_token?

  def user_token?
    object.user_token.present?

  end
end
