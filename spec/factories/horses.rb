FactoryGirl.define do
  factory :horse do
    sequence(:name) { |n| "Horse #{ n }" }
    age 5
  end
end
