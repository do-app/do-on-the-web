class CreateUsersChores < ActiveRecord::Migration
  def change
    create_table :users_chores do |t|
      t.integer :user_id, null: false
      t.integer :chore_id, null: false
      t.boolean :completed, default: false
      t.timestamps null: false
    end
  end
end
