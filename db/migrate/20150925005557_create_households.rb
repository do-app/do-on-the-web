class CreateHouseholds < ActiveRecord::Migration
  def change
    create_table :households do |t|
      t.string :name, null: false
      t.integer :head_of_household_id
      t.timestamps null: false
    end
  end
end
