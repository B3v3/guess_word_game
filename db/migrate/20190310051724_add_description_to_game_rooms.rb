class AddDescriptionToGameRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :game_rooms, :description, :text
  end
end
