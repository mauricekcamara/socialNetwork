class LookingFor < ActiveRecord::Migration
  def change
    add_column :users, :collaborators, :string
  end
end
