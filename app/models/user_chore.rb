class UserChore < ActiveRecord::Base
  self.table_name = 'users_chores'
  include AssignmentPeriod

  belongs_to :user
  belongs_to :chore 

  validates :user, presence: true
  validates :chore, presence: true

  def expired? 
    created_at < start_of_period
  end
end
