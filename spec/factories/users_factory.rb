FactoryGirl.define do
  factory :user do
    email { "#{username}@example.com" }
    sequence(:username) { |n| "user#{n}" }

    trait(:moderator) do
      moderator true
    end
  end
end
