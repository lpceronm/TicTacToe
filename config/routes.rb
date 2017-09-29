Rails.application.routes.draw do
  # resources :games
  get 'game/turn', to: 'games#turn'
  # get 'game/initialize', to: 'games#initialize'
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
