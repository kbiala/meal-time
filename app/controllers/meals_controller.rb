class MealsController < ApplicationController
  before_action :authenticate_with_token

  def create
    order = Order.find(params['order_id'])
    meal = Meal.create!(order: order, user: current_user, name: meal_params['name'], price: meal_params['price'])
    render status: :created, json: meal
  end

  def show
    meal = Meal.find(params['id'])
    render status: :ok, json: meal
  end

  def destroy
    Meal.destroy(params['id'])
    render status: :no_content, json: {}
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :price, :user_id)
  end
end
