class CreateApplyFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :apply_friends do |t|
      t.integer :user_id
      t.integer :friend_id
      t.timestamps
    end
  end
end
