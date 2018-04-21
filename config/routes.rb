Rails.application.routes.draw do
  resources :games, only: [:create, :show]
  put 'games/place'
  root 'games#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
