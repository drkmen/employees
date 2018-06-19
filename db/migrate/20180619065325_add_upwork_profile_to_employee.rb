class AddUpworkProfileToEmployee < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :upwork, :string
  end
end
