class UsersController < ApplicationController

  def my_friends
    @friendships = current_user.friends
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
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      redirect_to my_friends_path, notice: "Friend request sent."
    else
      redirect_to my_friends_path, flash[:error] = "There was an error sending the friend request.."
    end
  end
  
  def accept_friend
    @friendship = Friendship.find_by(id: params[:id])
    @friendship.update(status: "accepted")
    if @friendship.save
      redirect_to my_friends_path, notice: "Friendship successfully confirmed."
    else
      redirect_to my_friends_path, flash[:error] = "There was an error confirming the friendship"
    end  
  end

  def show
    @user = User.find(params[:id])
  end

end