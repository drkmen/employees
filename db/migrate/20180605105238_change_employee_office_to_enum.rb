class ChangeEmployeeOfficeToEnum < ActiveRecord::Migration[5.2]
  def change
    change_column_default :employees, :office, nil
    change_column :employees, :office, 'integer USING CAST(office AS integer)', default: 0
  end
end
