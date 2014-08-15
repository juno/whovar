Rails.application.routes.draw do
  root 'home#index'

  get 'auth/github/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/access_denied')
  get 'signin', to: 'sessions#new', as: :signin
  get 'signout', to: 'sessions#destroy', as: :signout
end
