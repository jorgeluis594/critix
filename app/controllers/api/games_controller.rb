class Api::GamesController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end
  def index
    render json: Game.all, status: :ok
  end
  def show
    game = Game.find(params[:id])
    render json: game
  end
  def create
    game = Game.create!(game_params)
    render json: game, status: :created
  end
  def update
    game = Game.find(params[:id])
    game.update(game_params)
    render json: game, status: :ok
  end
  def destroy
    Game.delete(params[:id])
    render json: {}, status: :no_content
  end


  private
  def game_params
    params.require(:game).permit(:name, :summary, :cover, :release_date, :category, :rating, :parent_id)
  end
end