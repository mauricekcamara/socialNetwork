class UsersController < ApplicationController

  def my_friends
    @friendships = current_user.friends
    @pending_friends = current_user.pending
  end

  def search
    @users = User.search(params[:search_param])
    if @users
      @users = current_user.except_current_user(@users)
      render "users/search_friends"
    else
      render status: :not_found, nothing: true
    end
  end

  def show
    @user = User.find(params[:id])
  end

end