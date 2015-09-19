class User < ActiveRecord::Base
  belongs_to :household
  has_many :events
  has_many :user_chores
  has_many :chores, through: :user_chores, source: :chore

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :points, presence: true
  validates :household, presence: true
end
