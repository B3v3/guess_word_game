class GameRoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_game_room, except: [:new, :create, :index]
  
  def index
    @game_rooms = GameRoom.all.page params[:page]
  end

  def show
    @guesses = @game_room.guesses.page params[:page]
  end

  def new
    @word = Word.find(Word.ids.sample)
    @game_room = GameRoom.new
  end

  def create
    @game_room = current_user.game_rooms.build(game_room_params)
    if @game_room.save
      redirect_to @game_room
    else
      render 'new'
    end
  end

  def update
    @game_room.update(game_room_params)
    redirect_to @game_room
  end

  def destroy
    @game_room.delete
    redirect_to game_rooms_path
  end

  private
  def find_game_room
    @game_room = GameRoom.friendly.find(params[:id])
  end

  def game_room_params
    params.require(:game_room).permit(:name, :description, :word_id)
  end
end
