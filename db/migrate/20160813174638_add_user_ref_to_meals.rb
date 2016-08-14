class AddUserRefToMeals < ActiveRecord::Migration[5.0]
  def change
    add_reference :meals, :user, index: true, foreign_key: true, null: false
  end
end
