FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{ n }@example.com" }
    password "password"
    password_confirmation "password"

    trait :business do
      after :build do |user, evaluator|
        build(:business_profile, user: user)
      end
    end
  end
end
