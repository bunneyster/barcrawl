class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :user, null: false
      t.references :friend, null: false

      t.timestamps
      
      t.index [:friend_id, :user_id], unique: true
      t.index [:user_id, :friend_id], unique: true
    end
  end
end
