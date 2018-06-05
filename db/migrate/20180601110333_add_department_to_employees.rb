class AddDepartmentToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :department, :integer
  end
end
