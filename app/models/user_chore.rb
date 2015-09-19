class UserChore < ActiveRecord::Base
  self.table_name = 'users_chores'

  belongs_to :user
  belongs_to :chore 
end
