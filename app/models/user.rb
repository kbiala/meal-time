# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  name        :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  facebook_id :integer
#

class User < ApplicationRecord
  has_many :meals
  has_many :orders, through: :meals

  validates_presence_of :name
end
