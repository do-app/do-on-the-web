class Household < ActiveRecord::Base
  has_many :users
  has_many :chores
  belongs_to :head_of_household, class_name: 'User',
                                  foreign_key: 'head_of_household_id'
end
