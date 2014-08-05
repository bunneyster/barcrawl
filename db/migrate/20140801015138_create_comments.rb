class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commenter, index: true, null: false
      t.references :tour_stop, index: true, null: false
      t.text :text, null: false, limit: 300

      t.datetime :created_at, null: false
      t.datetime :updated_at
    end
  end
end
