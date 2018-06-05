class GetRidOfPolymorphicAtRecourceSkill < ActiveRecord::Migration[5.2]
  def change
    remove_column :resource_skills, :skillable_id
    remove_column :resource_skills, :skillable_type
    add_column :resource_skills, :skill_id, :integer
    add_column :resource_skills, :project_id, :integer
    add_column :resource_skills, :employee_id, :integer
  end
end
