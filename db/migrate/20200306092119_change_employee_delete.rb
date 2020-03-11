class ChangeEmployeeDelete < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :deleted_at, :datetime
    Employee.deleted.update_all(deleted_at: DateTime.now)
    remove_column :employees, :deleted
  end
end
