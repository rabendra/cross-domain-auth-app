FactoryGirl.define do
  factory :profile do
    user nil
    birth_date { 18.years.ago }
  end

  factory :business_profile, parent: :profile, class: BusinessProfile.name do
    sequence(:first_name) { |n| "Business #{ n }" }

    profile 'reseller'
  end

  factory :personal_profile, parent: :profile, class: PersonalProfile.name do
    sequence(:first_name) { |n| "User #{ n }" }

    profile_type 'rider'
  end
end