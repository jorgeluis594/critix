class PlatformsController < ApplicationController
  def index
    @platforms = Platform.all.order(:name)
  end

  def new
    @game = Game.find(params[:game_id])
    @platform = @game.platforms.new
  end

  def create
    @game = Game.find(params[:game_id])
    @platform = Platform.find_or_initialize_by(platform_params)
    if @platform.save
      @game.platforms << @platform
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def destroy
    @game = Game.find(params[:game_id])
    @platform = Platform.find(params[:id])
    @game.platforms.delete(@platform)
    redirect_to game_path(@game)
  end

  def platform_params
    params.require(:platform).permit(:name, :category)
  end
end
