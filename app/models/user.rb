class User < ActiveRecord::Base
  belongs_to :household
  has_many :events
  has_many :user_chores
  has_many :chores, through: :user_chores, source: :chore
end
