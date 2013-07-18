Premin::Application.routes.draw do
  get "dashboard/index"

  devise_for :users

  get "home/index"

  constraints(Subdomain) do
    match "/" => "dashboard#index"
  end

  root :to => 'home#index'

  resources :accounts
end
