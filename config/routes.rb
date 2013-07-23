Premin::Application.routes.draw do
  get "dashboard/index"

  devise_for :users

  get "home/index"
  match "/customers" => "home#customers"
  match "/about" => "home#about"
  match "/contact" => "home#contact"
  match "/oops" => "home#oops"
  match "/news" => "home#news"

  constraints(Subdomain) do
    match "/" => "dashboard#index"
  end

  root :to => 'home#index'

  resources :accounts
end
