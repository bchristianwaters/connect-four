Rails.application.routes.draw do
  devise_for :users
  resources :games, only: [:create, :show]
  put 'games/place'
  root to: 'games#create'
end
