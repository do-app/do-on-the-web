class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :user_id
		t.integer :household_id
      t.timestamps null: false
    end
  end
end
