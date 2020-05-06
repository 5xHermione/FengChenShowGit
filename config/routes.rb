Rails.application.routes.draw do
  resources :repositories
  devise_for :users

  root "home#index"

  get "/:user_name", to: "repositories#index"
  get "/:user_name/:repository_title", to: "repository#show"
  get "/:user_name/:repository_title/issues", to: "issues#index"
  get "/:user_name/:repository_title/issues/new", to: "issues#new", as: "issue_new"
end


# /:user_name/:repo_name/issues  GET Issue/index
# params[:user_name]/params[:repo_title]/params[:issue_id]