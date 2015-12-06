class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.string :name, null: false
      t.integer :points, null: false
      t.integer :household_id, null: false
      t.timestamps null: false
    end
  end
end
