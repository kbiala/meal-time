class OrderSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :bank_account

  belongs_to :payer
  has_many :meals

  attribute :created_at do
    object.created_at.strftime("%Y-%m-%d %H:%M")
  end
end
