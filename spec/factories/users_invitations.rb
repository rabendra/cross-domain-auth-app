FactoryGirl.define do
  factory :users_invitation, class: Users::Invitation.name do
    association(:requestor, :user, :personal)
    sequence(:email) { |n| "user+#{ n }@gmail.com" }
    first_name "Lawrence"
    last_name "Washborne"
  end
end
