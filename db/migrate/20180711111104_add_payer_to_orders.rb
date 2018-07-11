class AddPayerToOrders < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :payer, index: true, foreign_key: { to_table: :users }
  end
end
