class FriendshipsController < ApplicationController
  def destroy
    @friendship = current_user.friendships.find_by(id: params[:id])
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to my_friends_path, notice: "Friend successfully removed"}
    end
  end
end