class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :uid
      t.integer :team_lead_id
      t.integer :employees_count, default: 0
      t.timestamps
    end
  end
end
