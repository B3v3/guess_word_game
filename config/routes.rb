Rails.application.routes.draw do
  #error handling
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  devise_for :users

  resources :game_rooms, except: [:edit] do
    resources :guesses, only: [:create]
  end

  resources :words, except: [:show, :edit, :update]
  resources :profiles, only: [:show, :index]

  root to: 'game_rooms#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
