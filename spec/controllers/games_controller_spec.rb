require 'rails_helper'

describe Api::GamesController do
  describe 'GET to index' do
    it 'returns http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end
    it 'render json with all games' do
      Game.create(name: "Game test", category: "main_game", rating: 50)
      get :index
      games = JSON.parse(response.body)
      expect(games.size).to eq 1
    end
  end
  describe 'GET to show' do
    it 'returns http status ok' do
      game = Game.create(name: 'New Game', category: "main_game")
      get :show, params: { id: game }
      expect(response).to have_http_status(:ok)
    end
    it 'render the correct game' do
      game = Game.create(name: 'New Game', category: "main_game")
      get :show, params: { id: game }
      expected_game = JSON.parse(response.body)
      expect(expected_game["id"]).to eql(game.id)
    end
    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end


end