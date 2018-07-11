class MealSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :order_id, :user_id, :username

  def username
    User.find(object.user_id).name
  end
end
