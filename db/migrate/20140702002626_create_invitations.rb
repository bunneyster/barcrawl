class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :user, index: true
      t.references :tour, index: true

      t.timestamps
    end
  end
end
