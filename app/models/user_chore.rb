class UserChore < ActiveRecord::Base
  self.table_name = 'users_chores'

  belongs_to :user
  belongs_to :chore 

  validates :user, presence: true
  validates :chore, presence: true
end
