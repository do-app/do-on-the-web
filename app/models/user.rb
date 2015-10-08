class User < ActiveRecord::Base
  has_secure_password
  before_validation :set_points

  belongs_to :household
  has_many :events
  has_many :user_chores
  has_many :chores, through: :user_chores, source: :chore


  validates :name, presence: true, uniqueness: true 
  validates :password, presence: true, confirmation: true 
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, confirmation: true, uniqueness: true

private
  def set_points
    self.points ||= 0
  end
	
	
end
