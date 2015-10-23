class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :points, null: false
      t.integer :household_id
      t.timestamps null: false
    end
  end
end
