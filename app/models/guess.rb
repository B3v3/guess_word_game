class Guess < ApplicationRecord
  belongs_to :game_room

  validates :text, presence: true, length: { minimum: 3, maximum: 32}
end
