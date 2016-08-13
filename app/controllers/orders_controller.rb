class OrdersController < ApplicationController
  def index
    render status: :ok, json: Order.all
  end

  def create
    begin
      order = Order.create!(order_params)
    rescue ActionController::ParameterMissing
      render status: :bad_request, json: {'error': 'bad params'}
      return
    end
    render status: :created, json: order
  end

  def show
    begin
      order = Order.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render status: :not_found, json: {'error': 'bad id given'}
      return
    end
    render status: :ok, json: order
  end

  def update
    begin
      order = Order.update(params[:id], order_params)
    rescue ActiveRecord::RecordNotFound
      render status: :not_found, json: {'error': 'bad id given'}
      return
    rescue ActionController::ParameterMissing
      render status: :bad_request, json: {'error': 'bad or no params given'}
      return
    end
    render status: :ok, json: order
  end

  def destroy
    begin
      Order.destroy(params[:id])
    rescue ActiveRecord::RecordNotFound
      render status: :not_found, json: {'error': 'bad id given'}
      return
    end
    render status: :no_content, json: {}
  end

  private

  def order_params
    params.require(:order).permit(:name, :meals, :status)
  end
end
