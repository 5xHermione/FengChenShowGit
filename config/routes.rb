Rails.application.routes.draw do
  devise_for :users, path: '', 
                     path_names: { 
                        sessions: "sessions", 
                        sign_up: 'register', 
                        sign_in: 'login', 
                        sign_out: 'logout'
                      }
  root "home#index"
  get ':user_name', to: "home#logined", as: "logined"

  scope '/:user_name' do
    resources :repositories do
      resources :issues
    end
  end
end
