class LikesController < ApplicationController
  def index
    @liked_repositories = find_user.liked_repositories
  end

  def create
    liked_repository = find_user.repositories.find_by(title: params[:repository_id])
    like_relationship = Like.new(repository_id: liked_repository.id, user_id: current_user.id)

    if like_relationship.save
      flash[:notice] = "Like success!"
    else
      flash[:notice] = " Fail to like this repository."
    end

    if params[:is_show]
      redirect_to repository_path(id: current_repository)
    else
      redirect_to repositories_path
    end
  end

  def destroy
    like_relationship = Like.find_by(repository_id: current_repository, user_id: current_user.id) || Like.find_by(repository_id: params[:repo_id], user_id: current_user.id)

    if like_relationship.destroy
      flash[:notice] = "Unlike success!"
    else
      flash[:notice] = "Fail to unlike this repository."
    end

    if params[:repo_id].present?
      redirect_to repositories_path
    else
      redirect_to repository_path(id: current_repository)
    end
  end
end