Rails.application.routes.draw do
  devise_for :users 
  resources :file_upload,only: %i[index show]
  resources :contacts do
    collection { post :import }
  end 
  resources :failcontacts, only: %i[index show]

  root 'home#index'
end
