class Message < ActiveRecord::Base

	belongs_to :household, class_name: 'Household', foreign_key: 'household_id'
	belongs_to :user, class_name: 'User', foreign_key: 'user_id'

end
