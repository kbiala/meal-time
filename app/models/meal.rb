# == Schema Information
#
# Table name: meals
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  price      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer          not null
#  user_id    :integer          not null
#

class Meal < ApplicationRecord
  belongs_to :order
  belongs_to :user

  validates_presence_of :name, :price, :user
  validate :user_has_meal?, :order_is_new?

  def order_is_new?
    if order.status != "New"
      errors.add(:order, 'has been finalized; cannot add new meals')
    end
  end

  def user_has_meal?
    unless user.orders.where(id: order.id).empty?
      errors.add(:user, 'already has a meal in this order')
    end
  end
end
