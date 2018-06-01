Rails.application.routes.draw do
  get 'users/show'

  get 'users/edit'

  devise_for :users
  resources :games, only: [:create, :show]
  put 'games/place'
  root to: 'games#create'
end
