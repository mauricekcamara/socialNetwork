class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      redirect_to my_friends_path, notice: "Friend request successfully sent."
    else
      redirect_to my_friends_path, flash[:error] = "There was an error sending the friend request."
    end
  end

  def update
    @friendship = Friendship.find_by(params[:id])
    @friendship.update(accepted: true)
    if @friendship.save
      redirect_to my_friends_path, notice: "Friendship successfully confirmed."
    else
      redirect_to my_friends_path, flash[:error] = "There was an error confirming the friendship."
    end
  end

  def destroy
    @friendship = Friendship.find_by(params[:id])
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to my_friends_path, notice: "Friendship was successfully removed"}
    end
  end
end