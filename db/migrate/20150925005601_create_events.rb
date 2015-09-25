class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.text :description
      t.timestamps null: false
    end
  end
end
