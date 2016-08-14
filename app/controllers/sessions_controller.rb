class SessionsController < ApplicationController
  def create
    #params[get omniauth data]
    #user = User.from_omniauth(params)
    #session[:user_id] = user.id
    render status: :created, json: {}
  end

  def destroy
    session[:user_id] = nil
    render status: :no_content, json: {}
  end
end
