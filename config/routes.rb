Rails.application.routes.draw do
  devise_for :users 
  resources :file_upload
  resources :contacts
  root 'home#index'
end
