class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
<<<<<<< HEAD
  rescue_from CanCan::AccessDenied do |exception|
  redirect_to main_app.root_url, :alert => exception.message
end
=======

  helper_method :get_the_user
  DummyUser = Struct.new(:full_name)

  def get_the_user(id)
    user = User.find_by(id: id)
    return user if user
    #user = DummyUser.new('deleted user')
  end
end
