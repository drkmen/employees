class AddLinkToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :link, :string
  end
end
