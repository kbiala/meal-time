class OrderSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :meals
end
