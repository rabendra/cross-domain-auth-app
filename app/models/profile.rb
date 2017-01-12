class Profile < ApplicationRecord
  belongs_to :user, required: true, inverse_of: :profile
  has_one :address, as: :addressable, dependent: :destroy, required: true

  accepts_nested_attributes_for :address

  mount_uploader :avatar, ProfileUploader

  validates :first_name, presence: true

  def serializer_class
    raise 'Implement in each subclass'
  end
end
