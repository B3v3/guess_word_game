class GuessesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_game_room
  before_action :check_if_game_room_master

  def create
    @guess = @game_room.guesses.build(guess_params)
    @guess.user = current_user
    if @guess.save
      if @guess.text.downcase == @game_room.word.name
        flash[:notice] = "You won!"
        @game_room.end_game(current_user)
        redirect_to root_path
      else
        flash[:alert] = 'Try again!'
        redirect_to @game_room
      end
    end
  end

  private
  def guess_params
    params.require(:guess).permit(:text)
  end

  def get_game_room
    @game_room = GameRoom.friendly.find(params[:game_room_id])
  end

  def check_if_game_room_master
    redirect_to @game_room if @game_room.user == current_user
  end
end
