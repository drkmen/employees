class CreateResourceSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :resource_skills do |t|
      t.references :skillable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
