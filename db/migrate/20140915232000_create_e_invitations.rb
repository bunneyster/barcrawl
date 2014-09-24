class CreateEInvitations < ActiveRecord::Migration
  def change
    create_table :e_invitations do |t|
      t.string :recipient, null: false
      t.string :tour_id, limit: 64, null: false
      
      t.index [:tour_id, :recipient], unique: true

      t.timestamps
    end
  end
end
