FitgemClient::Application.routes.draw do

  devise_for :users, :controllers => {:registrations => "users/registrations"}
  devise_scope :user do
    get '/login' => "devise/sessions#new"
    post '/login' => 'devise/sessions#create', :as => :user_session
    get '/logout' => 'devise/sessions#destroy'
    get '/signup' => "users/registrations#new"
  end

  get "profile" => 'users/profiles#show', :as => :user_profile

  # Speciality routing for the OAuth login flow
  scope "/fitbit" do
    get "connect", :controller => "oauth/fitbit", :action => :index, :as => :fitbit_connect
    post "start", :controller => "oauth/fitbit", :action => :start, :as => :fitbit_start
    get "verify", :controller => "oauth/fitbit", :action => :verify, :as => :fitbit_verify
    get "unlink", :controller => "oauth/fitbit", :action => :unlink, :as => :fitbit_unlink
    post "disconnect", :controller => "oauth/fitbit", :action => :disconnect, :as => :fitbit_disconnect
  end

  # Routing for the pages of the guide
  scope "/guide" do
    get "introduction", :controller => :guide, :action => :introduction
    get "getting-started", :controller => :guide, :action => :getting_started, :as => :getting_started
    get "using-fitgem", :controller => :guide, :action => :using_fitgem, :as => :using_fitgem
    get "fitbit-resources", :controller => :guide, :action => :fitbit_resources, :as => :fitbit_resources
    get "fitbit-subscriptions", :controller => :guide, :action => :fitbit_subscriptions, :as => :fitbit_subscriptions
    get "fitgem-on-rails", :controller => :guide, :action => :fitgem_on_rails, :as => :fitgem_on_rails
  end

  # Routes for the api interfaces
  namespace :api do
    get "user", :controller => "users", :action => "show"
    get "body_measurements", :controller => "body_measurements", :action => "show"
  end

  # Miscellaneous pages
  get "about", :controller => :welcome, :action => :about
  get "blog", :controller => :welcome, :action => :blog

  resources :notifications


  namespace :examples do
    resources :fitgem, :resources, :subscriptions
  end

  root :to => "welcome#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
