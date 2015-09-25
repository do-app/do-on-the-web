class User < ActiveRecord::Base
  has_secure_password
  belongs_to :household
  has_many :events
  has_many :user_chores
  has_many :chores, through: :user_chores, source: :chore

  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :name, presence: true
  validates :points, presence: true
  validates :household, presence: true
end
