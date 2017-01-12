class LoginSerializer < ActiveModel::Serializer
  attributes :api_key, :name, :type

  def api_key
    object.user_token
  end

  def type
    case object.profile
    when nil then 'pending'
    when PersonalProfile then 'person'
    when BusinessProfile then 'business'
    end
  end
end
