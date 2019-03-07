class AddSlugToGameRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :game_rooms, :slug, :string
    add_index :game_rooms, :slug, unique: true
  end
end
