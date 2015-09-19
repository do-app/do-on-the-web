class Chore < ActiveRecord::Base
  belongs_to :household
  has_many :user_chores
  has_many :users, through: :user_chores, source: :user

  validates :name, presence: true
  validates :points, presence: true
  validates :length_of_time, presence: true
  validates :times_per_week, presence: true
  validates :household, presence: true
  validates :points, :length_of_time, :times_per_week,
                                          numericality: {greater_than_or_equal_to: 0}
end
