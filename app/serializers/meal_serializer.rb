class MealSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :order_id
end
