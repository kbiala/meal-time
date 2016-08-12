class Order < ApplicationRecord
  has_many :meals

  validates_presence_of :name, :status
  validates :status, inclusion: {
    in: %w(New Finalized Ordered Delivered),
    message: "%{value} is not a valid status"
  }
end
