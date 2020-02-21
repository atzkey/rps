Rails.application.routes.draw do
  post 'game', to: 'game#create'

  root to: 'home#index'
end
