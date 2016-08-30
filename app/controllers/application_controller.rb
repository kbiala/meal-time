class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
  rescue_from ActiveRecord::RecordInvalid, ActionController::ParameterMissing, with: :bad_request_error

  def authenticate_with_token
    render status: :unauthorized, json: {} unless current_user.present?
  end

  private

  def current_user
    @current_user ||= User.find_by_access_token(params[:access_token])
  end
  helper_method :current_user

  def not_found_error(exception)
    render status: :not_found, json: default_error_message(exception)
  end

  def bad_request_error(exception)
    render status: :bad_request, json: default_error_message(exception)
  end

  def default_error_message(exception)
    { 'error': exception.message }
  end

end
