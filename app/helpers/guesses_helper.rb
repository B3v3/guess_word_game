module GuessesHelper
  def valid_for_guessing?(game_room)
    (!game_room.won? && user_signed_in? && current_user != game_room.user)
  end
end
