class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def authenticate_with_token
    render status: :unauthorized, json: {} unless current_user.present?
  end

  private

  def current_user
    @current_user ||= User.find_by_access_token(params[:access_token])
  end
  helper_method :current_user
end
