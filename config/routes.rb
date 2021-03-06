Rails.application.routes.draw do
  root 'groups#index'
  devise_for :users
  resources :groups, only: [:new, :create, :update, :edit, :index] do
    resources :messages
  end
  resources :users, only: [:index]
end
