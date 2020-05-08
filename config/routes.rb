Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :repositories do
    resources :issues
  end
end