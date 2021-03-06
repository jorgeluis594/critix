require 'rails_helper'
require 'byebug'
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

  describe 'Create game' do
    it 'should be create' do
      req_payload = {
          game: {
              name: "Name",
              summary: "text",
              category: :main_game,
              rating: 80
          }
      }
      post :create, params: req_payload
      payload = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(payload["id"]).not_to be_nil
    end
  end
  describe 'Update Game' do
   it 'should be update' do
     game = Game.create(name: "primer titulo", summary: "un texto", category: :main_game, rating: 99)
     req_payload = {
         id: game.id,
         game: {
             name: "segundo titulo",
             summary: "segundo text",
             rating: 90
         }
     }
     patch :update, params: req_payload
     payload = JSON.parse(response.body)
     expect(response).to have_http_status(:ok)
     expect(payload).not_to be_empty
     expect(payload["id"]).to eq(game.id)
   end
  end

  describe 'Delete Game' do
    it 'should be delete' do
      game = Game.create(name: "game a crear", summary: "un texto", category: :main_game, rating: 99)
      games_before = Game.all.size
      delete :destroy, params: {id: game}
      game_exists = Game.exists?(game.id)
      games_after = Game.all.size
      payload = JSON.parse(response.body)
      expect(response).to have_http_status(:no_content)
      expect(payload).to be_empty
      expect(games_after).to eq(games_before - 1)
      expect(game_exists).to be_falsey
    end
  end
end