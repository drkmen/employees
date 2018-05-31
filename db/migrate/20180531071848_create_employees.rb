class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :main_skill
      t.string :description
      t.string :email, null: false
      t.string :phone
      t.string :office
      t.integer :role, null: false, default: 0
      t.jsonb :additional, default: {}

      t.timestamps
    end

    add_index :employees, %i[first_name last_name main_skill], unique: true
    add_index :employees, :email, unique: true
  end
end
