class CreateUserRewards < ActiveRecord::Migration
  def change
    create_table :user_rewards do |t|
      t.integer :user_id, null: false
      t.integer :reward_id, null: false
      t.timestamps null: false
    end
  end
end
