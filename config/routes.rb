Rails.application.routes.draw do
  root to: 'home#root'

  get '/login', to: 'sessions#authorize', as: :login
  get '/logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#callback', as: :auth_callback

  get '/github', to: 'github#home', as: :github_home
end
