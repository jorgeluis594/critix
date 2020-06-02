class GamesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @games = Game.all.order(:name)
  end

  def show
    @game = Game.find(params[:id])
    @review = Review.new
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    authorize @game
    if @game.save
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    authorize @game
    if @game.update(game_params)
      redirect_to game_path(@game)
    else
      render :edit
    end
  end

  def destroy
    game = Game.find(params[:id])
    authorize game
    game.destroy
    redirect_to games_path
  end
  
  private
  
  def game_params
    params.require(:game).permit(:name, :summary, :cover, :release_date, :category, :rating, :parent_id)
  end
end
