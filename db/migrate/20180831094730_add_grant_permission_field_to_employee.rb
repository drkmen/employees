class AddGrantPermissionFieldToEmployee < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :grant_admin_permissions, :boolean, default: false
  end
end
