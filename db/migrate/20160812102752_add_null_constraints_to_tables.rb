class AddNullConstraintsToTables < ActiveRecord::Migration[5.0]
  def change
    change_column_null :meals, :name, false
    change_column_null :meals, :price, false
    change_column_null :orders, :name, false
    change_column_null :meals, :order_id, false
  end
end
