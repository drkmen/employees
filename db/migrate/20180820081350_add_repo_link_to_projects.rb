# frozen_string_literal: true

class AddRepoLinkToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :repository, :string
  end
end
