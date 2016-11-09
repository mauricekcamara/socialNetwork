class AddAvatarToProfileAndRemoveFromUser < ActiveRecord::Migration
  def change
    add_column :profiles, :avatar, :string
    remove_column :users, :avatar
    
  end
end
