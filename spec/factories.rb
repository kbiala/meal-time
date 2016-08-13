FactoryGirl.define do
  sequence :order_name do |n|
    "order#{n}"
  end

  sequence :meal_name do |n|
    "meal#{n}"
  end

  factory :order do
    name { generate(:order_name) }
    status 'New'
  end

  factory :meal do
    order
    name { generate(:meal_name) }
    price { rand(100) }
  end
end