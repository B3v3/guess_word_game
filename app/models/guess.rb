class Guess < ApplicationRecord
  belongs_to :game_room
  belongs_to :user
  
  validates :text, presence: true, length: { minimum: 3, maximum: 32}
end
