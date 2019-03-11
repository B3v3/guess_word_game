class CreateGuesses < ActiveRecord::Migration[5.2]
  def change
    create_table :guesses do |t|
      t.string :text
      t.integer :game_room_id

      t.timestamps
    end
  end
end
