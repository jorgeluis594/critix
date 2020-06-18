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
    devise_scope :user do
      post "sign_up", to: "registrations#create"
      post "sign_in", to: "sessions#create"
      delete "sign_out", to: "sessions#destroy"
    end
    resources :games, only: [:index, :show, :create, :update, :destroy]
  end

end
