Rails.application.routes.draw do
  devise_for :users 
  resources :file_upload
  resources :contacts do
    collection { post :import }
  end 

  root 'home#index'
end
