Rails.application.routes.draw do
  root 'groups#index'
  devise_for :users
  resources :messages
  resources :groups, only: [:new, :create, :update, :edit, :show, :index]
  
end
