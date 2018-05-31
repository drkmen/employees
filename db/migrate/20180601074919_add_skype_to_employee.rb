class AddSkypeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :skype, :string
    add_index :employees, :skype, unique: true
  end
end
