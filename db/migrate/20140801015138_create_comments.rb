class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commenter, index: true, null: false
      t.references :tour_stop, index: true, null: false

      t.timestamps
    end
  end
end
