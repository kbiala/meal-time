class OrdersController < ApplicationController
  respond_to :json

  def index
    respond_with Order.all
  end

  def create
    respond_with Order.create(order_params)
  end

  def show
    respond_with Order.find(params[:id])
  end

  def update
    respond_with Order.update(params[:id], params[:order])
  end

  def destroy
    respond_with Order.destroy(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:name)
  end
end
