require 'sidekiq/web'

# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use Rails.application.config.session_store, Rails.application.config.session_options

Rails.application.routes.draw do
  devise_for :users 
  resources :file_upload,only: %i[index show]
  resources :contacts do
    collection { post :import }
  end 
  resources :failcontacts, only: %i[index show]

  root 'home#index'
  mount Sidekiq::Web => "/sidekiq"
end
