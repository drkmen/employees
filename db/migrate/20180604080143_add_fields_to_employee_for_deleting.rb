class AddFieldsToEmployeeForDeleting < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :deleted, :boolean, default: false
    add_index :employees, :deleted
  end
end
