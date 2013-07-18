Premin::Application.routes.draw do
  devise_for :users

  get "home/index"

  root :to => 'home#index'

  resources :accounts
end
