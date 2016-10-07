class User::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  protected
  
  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

end