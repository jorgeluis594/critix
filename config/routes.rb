Rails.application.routes.draw do
  devise_for :users
  root "games#index"
  resources :games do
    resources :genres, only: [:new, :create, :destroy]
    resources :platforms, only: [:new, :create, :destroy]
  end
  resources :companies, only: :index
  resources :genres, only: :index
  resources :platforms, only: :index
end
