Ifeelfb::Application.routes.draw do
  
   # Connect Site
  resource :facebook, :except => :create do
    get :callback, :to => :create
  end
  resource :dashboard, :only => :show
  # resources :subscriptions, :only => [:index, :show, :create]
  post 'subscriptions/:id', :to => 'subscriptions#update'

  root :to => 'home#index'

end
