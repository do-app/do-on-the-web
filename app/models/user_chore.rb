class UserChore < ActiveRecord::Base
  self.table_name = 'users_chores'

  belongs_to :user
  belongs_to :chore 

  before_validation :set_completed

  validates :user, presence: true
  validates :chore, presence: true
  validates :completed, presence: true

  private
  def set_completed
    self.completed ||= false
  end
end
