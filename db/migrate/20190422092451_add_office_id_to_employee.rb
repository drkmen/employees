class AddOfficeIdToEmployee < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :office_id, :integer
  end
end
