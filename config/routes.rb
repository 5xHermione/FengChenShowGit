Rails.application.routes.draw do
  devise_for :users, path: '', 
                     path_names: { 
                        sessions: "sessions", 
                        sign_up: 'register', 
                        sign_in: 'login', 
                        sign_out: 'logout'
                      }, 
                      controllers: {
                        registrations: "user/registrations" 
                      }
  root "home#index"

<<<<<<< HEAD
  resources :repositories do
    resources :issues do
      member do
        get :toggle_status
      end
=======
  # resources :repositories do
  #   resources :issues
  # end

  scope '/:user_id' do
    resources :repositories do
      resources :issues
>>>>>>> 改寫 routes 作業中
    end
  end

end
# user save 的時候要存 slug 欄位。
# routes 要傳 id 東西進去，他會去找 slug 欄位。
