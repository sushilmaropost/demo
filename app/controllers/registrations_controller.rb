class RegistrationsController < Devise::RegistrationsController

  protected
  def after_sign_up_path_for(resource)
    @_request.reset_session
    new_user_session_path
  end
end
