class AddNumChoresToUsers < ActiveRecord::Migration
  def change
	add_column :users, :num_chores, :integer
  end
end
