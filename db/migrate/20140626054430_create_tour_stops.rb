class CreateTourStops < ActiveRecord::Migration
  def change
    create_table :tour_stops do |t|
      t.references :tour, index: true
      t.references :venue, index: true
      t.column :status, :integer, default: 0

      t.timestamps
    end
  end
end
