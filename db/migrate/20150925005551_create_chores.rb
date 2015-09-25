class CreateChores < ActiveRecord::Migration
  def change
    create_table :chores do |t|
      t.string :name, null: false
      t.integer :points, null: false
      t.integer :length_of_time, null: false
      t.integer :times_per_week, null: false
      t.integer :household_id, null: false
      t.timestamps null: false
    end
  end
end
