
class UserSerializer < ActiveModel::Serializer
  attributes  :id,
              :email

  attribute :user_token, if: :user_token?

  def user_token?
    object.user_token.present?

  end
end
