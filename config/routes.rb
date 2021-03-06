Rails.application.routes.draw do
  require 'sidekiq/web'
  
  # devise_for :admin_users, ActiveAdmin::Devise.config
  # #devise_for :admin_users, {class_name: 'User'}.merge(ActiveAdmin::Devise.config)
  # #devise_for :users, ActiveAdmin::Devise.config
  
  # ActiveAdmin.routes(self)
  # devise_for :users
  # root to: 'homes#index'
  
  # devise_for :users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)




  devise_for :admin_users, {class_name: 'User'}.merge(ActiveAdmin::Devise.config)
  #devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { registrations: "registrations" }

  resources :users
  root to: 'homes#index'

  resources :galleries do
    collection do
      post :import
      get  :counter
    end 
  end

  resources :contacts,:registrations,:abouts
  mount Sidekiq::Web => '/sidekiq'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, :only => [:create]
      resources :galleries, :only => [:create,:index]
      resources :contacts, :only => [:create]
    end
  end
  
end
