Rails.application.routes.draw do
  resources :games, only: [:index, :show, :new, :create, :edit, :update]
end
