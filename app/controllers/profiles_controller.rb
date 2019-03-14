class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order(score: 'desc')
  end

  def show
    @user = User.find(params[:id])
    @game_rooms_created = @user.game_rooms
    @won_games = @user.won_games
  end
end
