class AddStatusToChores < ActiveRecord::Migration
  def change
	add_column :chores, :status, :string
  end
end
