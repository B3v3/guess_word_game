class AddWinnerIdToGameRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :game_rooms, :winner_id, :integer
  end
end
