class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours, id: false do |t|
      t.string :id, limit: 64, null: false
      t.string :name, null: false, limit: 128
      t.references :organizer, null: false
      t.references :city, null: false
      t.datetime :starting_at, null: false
      t.string :image
      t.text :description, limit: 1000
      t.column :status, :integer, default: 0
      
      t.index :id, unique: true

      t.timestamps
    end
  end
end
