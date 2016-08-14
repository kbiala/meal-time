class MealSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :order_id, :user_id
end
