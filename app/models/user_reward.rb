class UserReward < ActiveRecord::Base
  belongs_to :user
  belongs_to :reward 

  validates :user, presence: true
  validates :reward, presence: true
end
