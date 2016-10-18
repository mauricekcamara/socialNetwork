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
      FriendshipNotifier.sent_friend_requests(@friend).deliver_now
      redirect_to my_friends_path, notice: "Friend request successfully sent."
    else
      redirect_to my_friends_path, flash[:error] = "There was an error sending the friend request"
    end
  end

  def accept_friend
    if current_user.accept_request(@friend)
      FriendshipNotifier.accepted_friend_requests(@friend).deliver_now
      redirect_to my_friends_path, notice: "Friend request successfully accepted."
    else
      redirect_to my_friends_path, flash[:error] = "There was an error accepting the friend request."
    end
  end

  def decline_friend
    if current_user.decline_request(@friend)
      redirect_to my_friends_path, notice: "Friend request successfully declined."
    else
      redirect_to my_friends_path, flash[:error] = "There was an error declining friend request."
    end
  end

  def remove_friend
    if current_user.remove_friend(@friend)
      redirect_to my_friends_path, notice: "Friendship successfully removed."
    else
      redirect_to my_friends_path, flash[:error] = "There was an error with removing friendship."
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def set_friend
    @friend = User.find(params[:friend])
  end

end