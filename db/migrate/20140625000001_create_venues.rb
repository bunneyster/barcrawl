class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.references :city
      t.integer :cid
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
