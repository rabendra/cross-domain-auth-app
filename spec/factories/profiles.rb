FactoryGirl.define do
  factory :profile do
    user
    birth_date { 18.years.ago }

    after :build do |profile, evaluator|
      profile.build_address(attributes_for(:address).merge(addressable: profile))
    end
  end

  factory :business_profile, parent: :profile, class: BusinessProfile.name do
    sequence(:first_name) { |n| "Business #{ n }" }

    profile_type 'reseller'
  end

  factory :personal_profile, parent: :profile, class: PersonalProfile.name do
    sequence(:first_name) { |n| "User #{ n }" }

    last_name 'Appleseed'
    bio 'Lorem ipsum'
    profile_type 'rider'
  end
end
