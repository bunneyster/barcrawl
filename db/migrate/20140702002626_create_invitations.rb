class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :sender, null: false
      t.references :recipient, null: false
      t.string :tour_id, limit: 64, null: false
      t.column :status, :integer, default: 0, null: false
      
      t.timestamps
      
      t.index [:tour_id, :recipient_id], unique: true
    end
  end
end
