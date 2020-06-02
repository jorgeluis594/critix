Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root "games#index"
  resources :games do
    resources :genres, only: [:new, :create, :destroy]
    resources :platforms, only: [:new, :create, :destroy]
    resources :involved_companies, only: [:new, :create, :destroy]
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :companies, only: :index
  resources :genres, only: :index
  resources :platforms, only: :index
  namespace :api do
    resources :games, only: [:index, :show]
  end

end
