Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  get "/:user_name", to: "repositories#index", as: "user" # repo的index
  get "/:user_name/new", to: "repositories#new", as: "new_repo"   # repo的new
  post ":user_name/create", to: "repositories#create", as: "create_repo" # repo的create
  get "/:user_name/:repository_title", to: "repositories#show", as: "repo"           # repo的show
  get "/:user_name/:repository_title/edit", to: "repositories#edit", as: "edit_repo" # repo的edit
  delete "/:user_name/:repository_title/destroy", to: "repositories#destroy", as: "destroy_repo" # repo的destroy
  patch "/:user_name/:repository_title/update", to: "repositories#update", as: "update_repo"  # repo的update

  get "/:user_name/:repository_title/issues", to: "issues#index", as: "issues" # issue的index
  get "/:user_name/:repository_title/issues/new", to: "issues#new", as: "new_issues" #issue的new
  post "/:user_name/:repository_title/issues/create", to: "issues#create", as: "create_issues" #issue的create
  get ":user_name/:repository_title/issues/:id", to: "issues#show", as: "show_issues" #issue的show
  get ":user_name/:repository_title/issues/:id/edit", to: "issues#edit", as: "edit_issues" #issue的edit
  delete "/:user_name/:repository_title/issues/:id/destroy", to: "issues#destroy", as: "destroy_issues" #issue的destroy
  patch "/:user_name/:repository_title/issues/:id/update", to: "issues#update", as: "update_issues" #issue的update

end


# /:user_name/:repo_name/issues  GET Issue/index
# params[:user_name]/params[:repo_title]/params[:issue_id]