Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sessions: "sessions", sign_up: 'register', sign_in: 'login', sign_out: 'logout'}
  root "home#index"

  resources :repositories do
    resources :issues do
      member do
        get :toggle_status
      end
    end
  end
end