class WordsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @words = Word.all
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      redirect_to words_path
    else
      render 'new'
    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy
  end

  private
    def word_params
      params.require(:word).permit(:name)
    end

    def authenticate_admin
      redirect_to root_path unless current_user.is_admin?
    end
end
