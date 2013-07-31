Premin::Application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'

  get "dashboard/index"

  devise_for :users

  get "home/index"
  match "/customers" => "home#customers"
  match "/about" => "home#about"
  match "/contact" => "home#contact"
  match "/oops" => "home#oops"
  match "/news" => "home#news"

  constraints(Subdomain) do
    authenticated :user do
      match "/" => "dashboard#index"
    end
    match "/" => "dashboard#public"
    resources :pages
    resources :courses
  end

  root :to => 'home#index'

  resources :accounts
end
