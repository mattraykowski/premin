Premin::Application.routes.draw do
  get "dashboard/index"

  devise_for :users

  get "home/index"
  match "/customers" => "home#customers"
  match "/oops" => "home#oops"

  constraints(Subdomain) do
    match "/" => "dashboard#index"
  end

  root :to => 'home#index'

  resources :accounts
end
