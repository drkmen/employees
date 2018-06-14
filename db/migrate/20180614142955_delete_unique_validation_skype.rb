class DeleteUniqueValidationSkype < ActiveRecord::Migration[5.2]
  def change
    remove_index :employees, :skype
  end
end
