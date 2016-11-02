class RemoveAvatarFromUsers < ActiveRecord::Migration
  def change
    remove_column :profiles, :avatar
  end
end
