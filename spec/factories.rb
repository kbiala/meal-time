FactoryBot.define do
  sequence :order_name do |n|
    "order#{n}"
  end

  sequence :meal_name do |n|
    "meal#{n}"
  end

  sequence :user_name do |n|
    "user#{n}"
  end

  sequence :facebook_id do |n|
    "1234#{n}".to_i
  end

  factory :order do
    name { generate(:order_name) }
    status 'New'
  end

  factory :user_with_facebook, class: User, aliases: [:user] do
    name { generate(:user_name) }
    facebook_id { generate(:facebook_id) }
    access_token 'asdf'
  end

  factory :user_with_github, class: User do
    name { generate(:user_name) }
    github_id 1
    access_token 'asdf'
  end

  factory :meal do
    order
    user
    name { generate(:meal_name) }
    price { rand(100) }
  end
end
