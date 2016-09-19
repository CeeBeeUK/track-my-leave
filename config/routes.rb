Rails.application.routes.draw do
  get 'user/new'
  get 'user/:id', to: 'user#show'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get 'login', to: 'home#login'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  root to: 'home#show'
end
