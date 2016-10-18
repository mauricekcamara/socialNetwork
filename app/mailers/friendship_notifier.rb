class FriendshipNotifier < ApplicationMailer
  default :from => 'do-not-reply@example.com'

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
