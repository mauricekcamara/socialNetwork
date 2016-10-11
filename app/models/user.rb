class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :friendships
  has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"
  
  has_many :active_friends, -> {where(friendships: {accepted: true})}, through: :friendships, source: :friend
  has_many :received_friends, -> {where(friendships: {accepted: true})}, through: :received_friendships, source: :user
  has_many :pending_friends, -> { where(friendships: { accepted: false}) }, through: :friendships, source: :friend
  has_many :requested_friendships, -> { where(friendships: { accepted: false}) }, through: :received_friendships, source: :user
  
  # to call all your friends
  def friends
    active_friends | received_friends
  end

# to call your pending sent or received
  def pending
    pending_friends | requested_friendships
  end
  
  mount_uploader :avatar, AvatarUploader
  validate :avatar_size

  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"
  end

  def not_friends_with?(friend_id)
    friendships.where(friend_id: friend_id).count < 1
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def self.search(param)
    return User.none if param.blank?

    param.strip!
    param.downcase!
    (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    where("lower(#{field_name}) like ?", "%#{param}%")
  end

  private

  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "Should be less than 5MB.")
    end
  end



end
