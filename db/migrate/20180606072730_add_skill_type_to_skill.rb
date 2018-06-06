class AddSkillTypeToSkill < ActiveRecord::Migration[5.2]
  def change
    add_column :skills, :skill_type, :integer, null: false, default: 0
  end
end
