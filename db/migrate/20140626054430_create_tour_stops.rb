class CreateTourStops < ActiveRecord::Migration
  def change
    create_table :tour_stops do |t|
      t.string :tour_id, limit: 64
      t.references :venue, index: true
      t.column :status, :integer, default: 0
      
      t.index :tour_id

      t.timestamps
    end
  end
end
