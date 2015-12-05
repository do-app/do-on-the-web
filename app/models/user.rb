class User < ActiveRecord::Base
  include AssignmentPeriod

  has_secure_password
  before_validation :set_points

  belongs_to :household, foreign_key: 'household_id'
  has_many :events
  has_many :user_chores
  has_many :messages
  has_many :assigned_chores, through: :user_chores, source: :chore
  has_many :households_is_head_of, class_name: 'Household', foreign_key: 'head_of_household_id'

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, confirmation: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :password, confirmation: true 
  validates :name, presence: true

  def chores
    assigned_chores.joins(:user_chores)
      .where("users_chores.created_at >= ?", start_of_period)
      .group('chores.id')
  end

  def uncompleted_chores
    assigned_chores.joins(:user_chores)
      .where("users_chores.created_at >= ? AND users_chores.completed = false", start_of_period)
      .group('chores.id')
  end

  private
    def set_points
      self.points ||= 0
    end
end
