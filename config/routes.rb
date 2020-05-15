Rails.application.routes.draw do
  devise_for :users, path: '', 
                     path_names: { 
                        sessions: "sessions", 
                        sign_up: 'register', 
                        sign_in: 'login', 
                        sign_out: 'logout'
                     }
  root "home#index"
  get ':user_name', to: "home#logged_in", as: "logged_in"

  scope '/:user_name' do
    resources :repositories do
      resources :issues do
        member do
          get :toggle_status
        end
      end
    end
  end
  get "/:user_name/repositories/:id/worktree/master/*file", to: "repositories#show" 

end
