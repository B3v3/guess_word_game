class Guess < ApplicationRecord
  validates :text, presence: true, length: { minimum: 3, maximum: 32}

  belongs_to :game_room
  belongs_to :user

  after_create :check_guess

  def check_if_same
    text.downcase == game_room.word.name.downcase
  end

  protected
  def check_guess
    game_room.end_game(user) if check_if_same
  end
end
