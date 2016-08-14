# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string(255)      default("New"), not null
#

class Order < ApplicationRecord
  has_many :meals, dependent: :destroy
  has_many :users, through: :meals

  validates_presence_of :name, :status
  validates :status, inclusion: {
    in: %w(New Finalized Ordered Delivered),
    message: "%{value} is not a valid status"
  }
end
