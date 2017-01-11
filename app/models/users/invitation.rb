class Users::Invitation < ApplicationRecord
  belongs_to :requestor, class_name: User.name, required: true
  validates :email, presence: true
  validate :ensure_user_is_not_in_system

  def name
    return email if full_name.blank?

    full_name
  end

  private

  def full_name
    [ first_name, last_name ].join(' ').strip
  end

  def ensure_user_is_not_in_system
    errors.add(:email, :already_exists) if User.find_by(email: email).present?
  end
end
