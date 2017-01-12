FactoryGirl.define do
  factory :horse do
    user

    sequence(:name) { |n| "Horse #{ n }" }
    age 5
    breed 'Walking Horse'
  end
end
