Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :games, only: [:show, :new, :create] do
     resources :messages, only: [:create]
  end
  put 'games/place'
  root to: 'games#create'
end
