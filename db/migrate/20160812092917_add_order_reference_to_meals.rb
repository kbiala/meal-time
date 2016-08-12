class AddOrderReferenceToMeals < ActiveRecord::Migration[5.0]
  def change
    add_reference :meals, :order, foreign_key: true
  end
end
