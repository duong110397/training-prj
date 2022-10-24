class RenameColumnAdminToRole < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :admin, :role
  end
end
