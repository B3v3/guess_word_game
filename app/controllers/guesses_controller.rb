class GuessesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_game_room
  before_action :check_if_game_room_master

  def create
    @guess = @game_room.guesses.build(guess_params)
    @guess.user = current_user
    if @guess.save
        flash[:notice] = winning_message
        redirect_to @game_room
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

  def winning_message
    @guess.check_if_same ? 'You won!' : 'Try again!'
  end
end
