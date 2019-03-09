class AddWordIdToGameRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :game_rooms, :word_id, :integer
  end
end
