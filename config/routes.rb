Rails.application.routes.draw do
  devise_for :users
  root "games#index"
  resources :games
  resources :companies, only: :index
  resources :genres, only: :index
  resources :platforms, only: :index
end
