FactoryGirl.define do
  factory :horse do
    user
    
    sequence(:name) { |n| "Horse #{ n }" }
    age 5
  end
end
