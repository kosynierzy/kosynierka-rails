FactoryGirl.define do
  factory :user do
    email { "#{username}@example.com" }
    sequence(:username) { |n| "user#{n}" }
  end
end
