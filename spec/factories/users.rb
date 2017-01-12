FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{ n }@example.com" }
    password "password"
    password_confirmation "password"

    trait :with_token do
      after :build do |user, evaluator|
        user.user_token = AuthenticationToken.encode(user.token_payload)
      end
    end

    trait :business do
      after :build do |user, evaluator|
        build(:business_profile, user: user)
      end
    end

    trait :personal do
      after :build do |user, evaluator|
        build(:personal_profile, user: user)
      end
    end
  end
end
