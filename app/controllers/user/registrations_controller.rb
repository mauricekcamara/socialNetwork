class User::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def new
    build_resource({})
    self.resource.education = education.new
    respond_with self.resource
  end

  protected
  
  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar, :avatar_cache, :title, :location, :currentprojects, :currentprojectsdesc, :collaborators])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar, :avatar_cache, :title, :location, :currentprojects, :currentprojectsdesc, :collaborators])
  end

  private
 
  def sign_up_params
    allow = [:email, :password, :password_confirmation, educations_attributes: [:title, :id]]
    params.require(resource_name).permit(allow)
  end


end