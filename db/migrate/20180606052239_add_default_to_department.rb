class AddDefaultToDepartment < ActiveRecord::Migration[5.2]
  def change
    change_column :employees, :department, :integer, default: 0, null: false
  end
end
