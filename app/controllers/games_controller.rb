class GamesController < ApplicationController
  def index
    games_with_rating = Game.all.where.not(rating: nil).order(rating: :desc)
    games_without_rating = Game.all.where(rating: nil)
    @games = games_with_rating + games_without_rating
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def destroy
    game = Game.find(params[:id])
    game.destroy
    redirect_to games_path
  end
  
  private
  
  def game_params
    params.require(:game).permit(:name, :summary, :release_date, :category, :rating, :parent_id)
  end
end
