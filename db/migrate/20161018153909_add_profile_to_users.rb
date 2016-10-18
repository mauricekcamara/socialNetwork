class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :title, :string
    add_column :users, :location, :string
  end
end
