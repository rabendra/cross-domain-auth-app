class Users::Invitation < ApplicationRecord
  belongs_to :requestor, class_name: User.name, required: true
  validates :email, presence: true

  def name
    return email if full_name.blank?

    full_name
  end

  private

  def full_name
    [ first_name, last_name ].join(' ').strip
  end
end
