class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :user, index: true
      t.string :tour_id, limit: 64
      
      t.index :tour_id

      t.timestamps
    end
  end
end
