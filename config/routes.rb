Rails.application.routes.draw do
  root "home#index"

  get "/auth/github", as: :github_login

  get '/auth/:provider/callback', to: "sessions#create"

  delete "/logout", to: "sessions#destroy", as: :logout

  resources :users, only: [:show]
end
