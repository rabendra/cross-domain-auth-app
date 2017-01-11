class BaseProfileSerializer  < ActiveModel::Serializer
  attributes :id, :email, :bio, :birth_date, :profile_type, :avatar

  delegate :id, :email, to: :user

  def avatar
    object.avatar.url
  end

  def birth_date
    return if object.birth_date.blank?

    object.birth_date.iso8601
  end

  private

  def user
    @user ||= object.user
  end
end
