class UserSerializer < ActiveModel::Serializer
  attributes  :id,
              :username,
              :email
  attribute :user_token, if: :user_token?

  def user_token?
    true if object.user_token
  end
end