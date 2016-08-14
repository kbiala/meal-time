FactoryGirl.define do
  sequence :order_name do |n|
    "order#{n}"
  end

  sequence :meal_name do |n|
    "meal#{n}"
  end

  sequence :user_name do |n|
    "user#{n}"
  end

  factory :order do
    name { generate(:order_name) }
    status 'New'
  end

  factory :user do
    name { generate(:user_name) }
    facebook_id 1
  end

  factory :meal do
    order
    user
    name { generate(:meal_name) }
    price { rand(100) }
  end
end
