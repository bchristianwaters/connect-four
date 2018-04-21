Rails.application.routes.draw do
  resources :games, only: [:create, :show]
  put 'games/place'
  root 'games#create'
end
