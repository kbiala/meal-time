class MealsController < ApplicationController
  before_action :authenticate_with_token

  def create
    begin
      order = Order.find(params['order_id'])
      meal = Meal.create!(order: order, user: current_user, name: meal_params['name'], price: meal_params['price'])
    rescue ActiveRecord::RecordNotFound => e
      render status: :not_found, json: { 'error': e.message }
      return
    rescue ActionController::ParameterMissing, ActiveRecord::RecordInvalid => e
      render status: :bad_request, json: { 'error': e.message }
      return
    end
    render status: :created, json: meal
  end

  def show
    begin
      meal = Meal.find(params['id'])
    rescue ActiveRecord::RecordNotFound
      render status: :not_found, json: {}
      return
    end
    render status: :ok, json: meal
  end

  def destroy
    begin
      Meal.destroy(params['id'])
    rescue ActiveRecord::RecordNotFound
      render status: :not_found, json: {}
      return
    end
    render status: :no_content, json: {}
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :price, :user_id)
  end
end
