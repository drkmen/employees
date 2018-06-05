class MoveSkillLevelToIntermediateTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :skills, :level
    add_column :resource_skills, :level, :integer
  end
end
