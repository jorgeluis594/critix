class GenresController < ApplicationController
  def index
    @genres = Genre.all.order(:name)
  end

  def new
    @game = Game.find(params[:game_id])
    @genre = @game.genres.new
  end

  def create
    @game = Game.find(params[:game_id])
    @genre = Genre.find_or_initialize_by(genre_params)
    if @genre.save
      @game.genres << @genre
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def destroy
    @game = Game.find(params[:game_id])
    @genre = Genre.find(params[:id])
    @game.genres.delete(@genre)
    redirect_to game_path(@game)
  end

  def genre_params
    params.require(:genre).permit(:name)
  end
end
