class UsersController < ApplicationController
  before_action :set_friend, only: [:add_friend, :accept_friend, :decline_friend, :remove_friend]

  def my_friends
    @friendships = current_user.friends
    @requested_friends = current_user.requested_friends
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

  def add_friend
    if current_user.friend_request(@friend)
      redirect_to my_friends_path, notice: "User was successfully added"
    else
      redirect_to my_friends_path, flash[:error] = "There was an error with adding user as connection."
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def accept_friend
    if current_user.accept_request(@friend)
      redirect_to my_friends_path, notice: "User was successfully accept"
    else
      redirect_to my_friends_path, flash[:error] = "There was an error with accepting user as connection."
    end
  end

  def decline_friend
    if current_user.decline_request(@friend)
      redirect_to my_friends_path, notice: "User was successfully declined"
    else
      redirect_to my_friends_path, flash[:error] = "There was an error with declining user as connection."
    end
  end

  def remove_friend
    if current_user.remove_friend(@friend)
      redirect_to my_friends_path, notice: "User was successfully removed"
    else
      redirect_to my_friends_path, flash[:error] = "There was an error with removing user as connection."
    end
  end

  private
    def set_friend
      @friend = User.find(params[:friend])
    end
end
