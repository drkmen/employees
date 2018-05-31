class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.datetime :start_date
      t.datetime :end_date
      t.string :description
      t.string :client

      t.references :employee
      t.timestamps
    end
  end
end
