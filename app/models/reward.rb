class Reward < ActiveRecord::Base
  belongs_to :household

  validates :name, presence: true
  validates :points, presence: true
  validates :household, presence: true
  validates :points, numericality: {greater_than_or_equal_to: 0}
end
