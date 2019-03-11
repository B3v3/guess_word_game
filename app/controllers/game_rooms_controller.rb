class GameRoomsController < ApplicationController
  def index
    @game_rooms = GameRoom.all
  end

  def show
    @game_room = GameRoom.friendly.find(params[:id])
    @guesses = @game_room.guesses
  end

  def new
    @game_room = GameRoom.new
  end

  def create
    @game_room = GameRoom.new(game_room_params)
    if @game_room.save
      redirect_to @game_room
    else
      render 'new'
    end
  end

  def update
    @game_room = GameRoom.friendly.find(params[:id])
    @game_room.update(game_room_params)
    redirect_to @game_room
  end

  def destroy
    game_room = GameRoom.friendly.find(params[:id])
    game_room.delete
    redirect_to game_rooms_path
  end

  private
  def game_room_params
    params.require(:game_room).permit(:name, :description, :word_id)
  end
end
