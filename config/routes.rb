Rails.application.routes.draw do
  devise_for :players, controllers: { omniauth_callbacks: 'players/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  resources :dashboards
  get '/games_dashboard', to: 'dashboards#games_dashboard'
  resources :games do
    member do
      patch :join
    end
  end
  resources :pieces
  post '/forfeit', to: 'games#forfeit'
end
