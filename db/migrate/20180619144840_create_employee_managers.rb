class CreateEmployeeManagers < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_managers do |t|
      t.integer :developer_id
      t.integer :manager_id
      t.timestamps
    end
  end
end
