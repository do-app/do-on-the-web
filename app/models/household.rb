class Household < ActiveRecord::Base
 # include AssignmentPeriod
  before_save :add_head_of_household_to_members

  has_many :members, class_name: 'User'
  has_many :messages, class_name: 'Message'
  has_many :chores
  belongs_to :head_of_household, class_name: 'User',
                                  foreign_key: 'head_of_household_id'

  validates :name, presence: true
  validates :head_of_household, presence: true
 # validates :members, presence: true

  def self.search(query)
    where("name like ?", "%#{query}%") 
  end

  def max_chores_per_member
    (chores.count / members.count.to_f).ceil
  end

  def assigned_chores
    chores.joins(:user_chores)
      .where("users_chores.created_at >= ?", start_of_period)
      .group('chores.id')
  end

  # TODO: Speed this query up with smarter query statement
  def unassigned_chores
    chores - assigned_chores
  end

  def assign_remaining_chores 
    if unassigned_chores
      unassigned_chores.each do |chore|
        u = members.sample
        while u.chores.count >= max_chores_per_member do 
          u = members.sample
        end 
        u.chores << chore
        u.save
      end
    end
  end

  private
  def add_head_of_household_to_members
    members << head_of_household
  end

end
