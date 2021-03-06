Rails.application.routes.draw do
  devise_for :users, controllers: {
                        registrations: 'users/registrations',
                        omniauth_callbacks: "users/omniauth_callbacks"
                     }, 
                     path_names: { 
                        sessions: "sessions", 
                        sign_up: 'register', 
                        sign_in: 'login', 
                        sign_out: 'logout'
                     }

  root "home#index" 
  resources :home , only: [:index] do
    collection do 
      get :verification
    end
  end
  get ':user_name', to: "home#logged_in", as: "logged_in"
  resources :sshkeys, only:[:new, :create, :destroy]

  scope '/:user_name' do
    resources :relationships, only: [:index, :create, :destroy]
    get "relationships/followers", to: "relationships#followers", as: "followers"
    resources :likes, only: [:index]
    get "repository/:id/branches", to: "repositories#branches", as: "branches"
    post "repository/:id/branches/delete", to: "repositories#branch_delete", as: "branch_delete"
    get "repository/:id/commits", to: "repositories#commits", as: "commits"
    post "repository/:id/checkout", to: "repositories#checkout", as: "checkout"
    get "repository/:id/commit/diff", to: "repositories#commit_diff", as: "commit_diff"
    resources :repositories do
      resources :likes, only: [:create, :destroy]
      resources :pull_requests do
        member do
          get "commits", to: "pull_requests#commits", as: "commits"
          get "files_changed", to: "pull_requests#files_changed", as: "files_changed"
        end
        resources :comments, only:[:create, :update, :destroy]
        collection do
          get :compare
          get :diff
          get :close_index
        end
        member do
          post :merge
          post :close
          post :reopen
        end
      end
      resources :issues do
        resources :comments, only:[:create, :update, :destroy]
        member do
          get :toggle_status      
        end
      end
    end
  end
  get "/:user_name/repositories/:id/worktree/master/*file", to: "repositories#show" 

end
