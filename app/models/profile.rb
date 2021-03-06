class Profile < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  has_many :schools
  has_many :skills
  accepts_nested_attributes_for :schools, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :skills, reject_if: :all_blank, allow_destroy: true
end
