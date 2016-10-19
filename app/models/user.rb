class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_friendship
  has_many :educations
  mount_uploader :avatar, AvatarUploader
  validate :avatar_size
  accepts_nested_attributes_for :educations

  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"
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
