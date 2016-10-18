class CompleteProfileForUsers < ActiveRecord::Migration
  def change
    add_column :users, :currentprojects, :string
    add_column :users, :currentprojectsdesc, :text
  end
end
