Rails.application.routes.draw do
  root "users#index"
  devise_for :users
  get "message" => "messages#index"
end
