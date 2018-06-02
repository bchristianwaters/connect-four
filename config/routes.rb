Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :games, only: [:show]
  put 'games/place'
  root to: 'games#create'
end
