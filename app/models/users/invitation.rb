class Users::Invitation < ApplicationRecord
  belongs_to :requestor, class_name: User.name, required: true
  validates :email, presence: true
end
