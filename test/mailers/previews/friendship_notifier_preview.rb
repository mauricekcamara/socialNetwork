# Preview all emails at http://localhost:3000/rails/mailers/friendship_notifier
class FriendshipNotifierPreview < ActionMailer::Preview
  def sent_friend_requests(friend)
    @friend = friend
    mail( :to => @friend.email,
          :subject => 'You have received a friend request.' )
  end
  
  def accepted_friend_requests(friend)
    @friend = friend
    mail( :to => @friend.email,
          :subject => 'Your friend request has been accepted.' )
  end

end
