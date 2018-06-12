class RemoveDeletedAtFromParanoiac < ActiveRecord::Migration[5.2]
  def change
    remove_column :employees, :deleted_at, :datetime
  end
end
