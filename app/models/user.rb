class User < ActiveRecord::Base
  has_secure_password
  before_validation :set_points

  belongs_to :household
  has_many :events
  has_many :user_chores
  has_many :chores, through: :user_chores, source: :chore
  has_many :households_is_head_of, class_name: 'Household', foreign_key: 'head_of_household_id'

  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :name, presence: true
  validates :points, presence: true

  private
  def set_points
    self.points ||= 0
  end
end
