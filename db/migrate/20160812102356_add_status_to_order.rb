class AddStatusToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :status, :string, null: false, default: 'New'
  end
end
