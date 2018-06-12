class AddEmployeeToSkill < ActiveRecord::Migration[5.2]
  def change
    add_reference :skills, :employee, foreign_key: true
  end
end
