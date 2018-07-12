class AddBankAccountToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :bank_account, :string
  end
end
