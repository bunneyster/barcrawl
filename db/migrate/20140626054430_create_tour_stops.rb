class CreateTourStops < ActiveRecord::Migration
  def change
    create_table :tour_stops do |t|
      t.string :tour_id, limit: 64, null: false
      t.references :venue, index: true, null: false
      t.column :status, :integer, default: 0, null: false
      
      t.index :tour_id

      t.timestamps
    end
  end
end
