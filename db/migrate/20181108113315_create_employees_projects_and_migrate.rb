class CreateEmployeesProjectsAndMigrate < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_projects do |t|
      t.belongs_to :employee,      null: false,    index: true
      t.belongs_to :project,       null: false,    index: true
    end

    Project.all.each { |project| EmployeeProject.create!(employee_id: project.employee_id, project_id: project.id) }

    remove_column :projects, :employee_id
  end
end
