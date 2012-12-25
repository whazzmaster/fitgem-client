FitgemClient::Application.routes.draw do

  devise_for :users, controllers: {registrations: "users/registrations", omniauth_callbacks: "omniauth_callbacks"}
  devise_scope :user do
    get '/logout' => 'devise/sessions#destroy'
    get '/signup' => "users/registrations#new"
  end

  get "profile" => 'users/profiles#show', as: :user_profile

  # Routing for the pages of the guide
  scope "/guide" do
    get "introduction", controller: :guide, action: :introduction
    get "getting-started", controller: :guide, action: :getting_started, as: :getting_started
    get "using-fitgem", controller: :guide, action: :using_fitgem, as: :using_fitgem
    get "fitbit-resources", controller: :guide, action: :fitbit_resources, as: :fitbit_resources
    get "fitbit-subscriptions", controller: :guide, action: :fitbit_subscriptions, as: :fitbit_subscriptions
    get "fitgem-on-rails", controller: :guide, action: :fitgem_on_rails, as: :fitgem_on_rails
  end

  # Routes for the api interfaces
  namespace :api do
    get "user", controller: "users", action: "show"
    get "body_measurements", controller: "body_measurements", action: "show"
  end

  # Miscellaneous pages
  get "about", controller: :welcome, action: :about
  get "blog", controller: :welcome, action: :blog

  resources :notifications

  root to: "welcome#index"
end
