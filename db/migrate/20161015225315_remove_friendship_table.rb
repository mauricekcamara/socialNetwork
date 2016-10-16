class RemoveFriendshipTable < ActiveRecord::Migration
  def up
    drop_table :friendships
  end
  
  def down
    create_table :friendships do |t|
      t.belongs_to :user
      t.belongs_to :friend, class: 'User'

      t.timestamps null: false
    end
  end
end
