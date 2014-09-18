class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :user, index: true, null: false
      t.string :tour_id, limit: 64, null: false
      
      t.timestamps
      
      t.index :tour_id
      t.index [:user_id, :tour_id], unique: true
    end
  end
end
