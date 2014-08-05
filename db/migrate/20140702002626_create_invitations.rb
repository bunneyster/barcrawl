class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :user, index: true, null: false
      t.string :tour_id, limit: 64, null: false
      
      t.index :tour_id

      t.timestamps
    end
  end
end
