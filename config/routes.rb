Rails.application.routes.draw do
  
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



  # # default_url_options :host => "maropost.dev"
  # root to: 'homes#index'
  #  devise_for :users, controllers: { registrations: "registrations" }
  #  devise_for :admin_users, ActiveAdmin::Devise.config
  #  ActiveAdmin.routes(self)


   resources :contacts,:galleries,:registrations,:abouts
end