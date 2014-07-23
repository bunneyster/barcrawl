class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 28
      t.string :email, null: false, limit: 38
      t.string :avatar_url
      t.string :password_digest, null: false
      
      t.index :email, unique: true

      t.timestamps
    end
  end
end
