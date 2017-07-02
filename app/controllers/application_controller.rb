class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # add additional name and role parameters to devise user model
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # alert for lack of pundit authorization or scope check in development
  # after_action :verify_authorized, except: [:index, :about]
  # after_action :verify_policy_scoped, only: :index

  # rescue pundit authorization errors
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # adding additional devise paramaters
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :email, :password, :password_confirmation])
  end
  
  # rescuing pundit authorization errors
  private
  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    flash[:alert] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_to(request.referrer || root_path)
  end
end
