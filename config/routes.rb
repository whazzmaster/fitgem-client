FitgemClient::Application.routes.draw do
  devise_for :users, controllers: {registrations: 'users/registrations', omniauth_callbacks: 'omniauth_callbacks'}
  devise_scope :user do
    get '/logout' => 'devise/sessions#destroy'
  end

  get 'profile' => 'users/profiles#show', as: :user_profile

  # Routing for the pages of the guide
  scope '/guide' do
    # chapter 1: introduction
    get 'introduction', controller: :guide, action: :introduction, as: :guide_introduction
    # chapter 2: playing with fitgem api
    get 'playing-with-the-fitgem-api', controller: :guide, action: :using_fitgem, as: :guide_using_fitgem
    # chapter 3: fetch/log user information from fitbit
    get 'fitbit-resources-user-information', controller: :guide, action: :user_information, as: :guide_user_information
    # chapter 4: fetch/log body measurement data from fitbit
    get 'fitbit-resources-body-measurements', controller: :guide, action: :body_measurements, as: :guide_body_measurements
    # chapter 5: fetch/log activity data from fitbit
    get 'fitbit-resources-activities', controller: :guide, action: :activities, as: :guide_activities
    # chapter 6: fetch/log food data from fitbit
    get 'fitbit-resources-foods', controller: :guide, action: :foods, as: :guide_foods
    # chapter 7: fitbit data subscriptions
    get 'fitbit-data-subscriptions', controller: :guide, action: :subscriptions, as: :guide_subscriptions
    # chapter 8: fitgem on rails
    get 'fitgem-on-rails', controller: :guide, action: :fitgem_on_rails, as: :guide_fitgem_on_rails
  end

  # Routes for the api interfaces
  namespace :api do
    get 'user', controller: 'users', action: 'show'
    get 'body_measurements', controller: 'body_measurements', action: 'show'
    get 'activities', controller: 'activities', action: 'index'
    post 'activity', controller: 'activities', action: 'create'
  end

  # Miscellaneous pages
  get 'about', controller: :welcome, action: :about
  get 'blog', controller: :welcome, action: :blog

  resources :notifications

  root to: 'welcome#index'
end
