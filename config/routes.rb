Rails.application.routes.draw do
  devise_for :players, controllers: { omniauth_callbacks: 'players/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  resources :games
end
