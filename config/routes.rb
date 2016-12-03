Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  get "message" => "messages#index"
end
