class Meal < ApplicationRecord
  belongs_to :order

  validates_presence_of :name, :price
end
