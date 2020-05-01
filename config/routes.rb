Rails.application.routes.draw do
  resources :repositories
  devise_for :users
  root "home#index"
end
