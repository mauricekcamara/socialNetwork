class AddObjective < ActiveRecord::Migration
  def change
    add_column :profiles, :description, :text
  end
end
