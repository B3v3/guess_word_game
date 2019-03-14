class AddUserIdToGameRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :game_rooms, :user_id, :integer
  end
end
