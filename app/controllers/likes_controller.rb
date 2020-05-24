class LikesController < ApplicationController
  def index
    @liked_repositories = find_user.liked_repositories
  end

  def create
    liked_repository = find_user.repositories.find_by(title: params[:repository_id])
    like_relationship = Like.new(repository_id: liked_repository.id, user_id: current_user.id)
    if like_relationship.save
      flash[:notice] = "Like success"
    else
      flash[:notice] = "Like unsuccess"
    end
    redirect_to repository_path(id: current_repository)
  end

  def destroy
    like_relationship = Like.find_by(repository_id: current_repository.id, user_id: current_user.id)
    byebug
    if like_relationship.destroy
      flash[:notice] = "Unlike success"
    else
      flash[:notice] = "Unlike unsuccess"
    end
    redirect_to repository_path(id: current_repository)
  end
end