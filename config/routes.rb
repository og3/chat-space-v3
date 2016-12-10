Rails.application.routes.draw do
  root 'messages#index'
  devise_for :users
  resources :messages
  resources :groups, only: [:new, :create, :update, :edit]
  
end
