class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #protect_from_forgery with: :null_session
  # before_action :configure_permitted_parameters, if: :devise_controller?

  # def configure_permitted_parameters
  #   update_attrs = [:password, :password_confirmation, :current_password]
  #   devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  # end

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

end
