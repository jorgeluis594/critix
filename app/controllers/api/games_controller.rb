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
end