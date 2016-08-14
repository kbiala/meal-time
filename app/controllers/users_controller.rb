class UsersController < ApplicationController
  def create
    render status: :created, json: User.create!(user_params)
  end

  def show
    begin
      user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render status: :not_found, json: {}
      return
    end
    render status: :ok, json: user
  end

  private

  def user_params
    params.require(:user).permit(:name, :facebook_id)
  end
end
