class AddAdminToUser < ActiveRecord::Migration
  change_table(:users) do |t|
    t.column :admin, :boolean, default: false, null: false
  end
end
