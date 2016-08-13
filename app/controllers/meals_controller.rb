class MealsController < ApplicationController
  def create
    begin
      order = Order.find(params['order_id'])
      meal = Meal.create!(order: order, name: meal_params['name'], price: meal_params['price'])
    rescue ActiveRecord::RecordNotFound
      render status: :not_found, json: { 'error': 'bad id given' }
      return
    rescue ActionController::ParameterMissing, ActiveRecord::RecordInvalid
      render status: :bad_request, json: { 'error': 'bad params' }
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
    params.require(:meal).permit(:name, :price)
  end
end
