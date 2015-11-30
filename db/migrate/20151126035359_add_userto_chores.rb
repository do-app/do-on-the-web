class AddUsertoChores < ActiveRecord::Migration
  def change
	add_column :chores, :user_id, :integer
  end
end
