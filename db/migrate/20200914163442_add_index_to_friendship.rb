class AddIndexToFriendship < ActiveRecord::Migration[5.2]
  def change
    add_index :friendships, :friendship_status
  end
end
