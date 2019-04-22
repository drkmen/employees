class CreateOffices < ActiveRecord::Migration[5.2]
  def change
    create_table :offices do |t|
      t.string :name
      t.integer :department_id
      t.integer :employees_count, default: 0

      t.timestamps
    end
  end
end
