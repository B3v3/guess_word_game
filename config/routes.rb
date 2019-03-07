Rails.application.routes.draw do
  devise_for :users

  resources :game_rooms, except: [:edit]

  root to: 'game_rooms#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
