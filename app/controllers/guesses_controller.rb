class GuessesController < ApplicationController
  def create
    @game_room = GameRoom.friendly.find(params[:game_room_id])
    @guess = @game_room.guesses.build(guess_params)
      if @guess.save
        if @guess.text.downcase == @game_room.word.name
          flash[:success] = "You won!"
          @game_room.end_game
        end
      end
      redirect_to @game_room
  end

  private
  def guess_params
    params.require(:guess).permit(:text)
  end
end
