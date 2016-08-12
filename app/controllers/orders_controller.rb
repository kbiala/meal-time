class OrdersController < ApplicationController

  def index
    render json: Order.all.includes(:meals)
  end

  def create
    render json: Order.create(order_params)
  end

  def show
    render json: Order.find(params[:id])
  end

  def update
    render json: Order.update(params[:id], params[:order])
  end

  def destroy
    render json: Order.destroy(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:name, :meals)
  end
end
