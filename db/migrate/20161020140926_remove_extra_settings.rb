class RemoveExtraSettings < ActiveRecord::Migration
  def change
    remove_column :users, :location, :string
    remove_column :users, :currentprojects, :string
    remove_column :users, :currentprojectsdesc, :text
    remove_column :users, :collaborators, :string
  end
end
