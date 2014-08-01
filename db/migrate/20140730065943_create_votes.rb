class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :voter, index: true, null: false
      t.references :tour_stop, index: true, null: false
      t.integer :score, null: false

      t.timestamps
    end
  end
end
