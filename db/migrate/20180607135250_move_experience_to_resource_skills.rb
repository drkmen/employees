class MoveExperienceToResourceSkills < ActiveRecord::Migration[5.2]
  def change
    remove_column :skills, :experience
    add_column :resource_skills, :experience, :string
  end
end
