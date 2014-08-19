class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name, null: false
      t.references :city, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.decimal :stars, precision: 2, scale: 1, null: false
      t.integer :rating_count, null: false
      t.string :image_url, null: false
      t.string :yelp_id, null: false
      
      t.index :yelp_id, unique: true

      t.timestamps
    end
  end
end
