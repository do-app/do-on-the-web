class AddChoresToMessages < ActiveRecord::Migration
  def change
	add_column :messages, :chore_id, :integer
  end
end
