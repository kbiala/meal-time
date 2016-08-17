class SessionsController < ApplicationController
  before_action :authenticate_with_token, only: [:authenticate]

  def authenticate
    render status: :ok, json: current_user, Serializer: UserSerializer
  end

  def create
    user = nil
    if (params[:provider] == 'facebook')
      user = User.from_omniauth(request.env['omniauth.auth'])
    elsif (params[:provider] == 'github')
      user = User.from_github(params[:code])
    end
    render status: :created, json: { name: user.name, access_token: user.access_token }
  end

  def destroy
    render status: :no_content, json: {}
  end

  private

  def user_params
    params.require(:user).permit(:name, :facebook_id, :facebook_token)
  end
end
