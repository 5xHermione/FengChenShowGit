class LikesController < ApplicationController
  def index
    @liked_repositories = find_user.liked_repositories
  end

  def create
    if @liked_repository = current_user.liked_repositories.create(current_repository.id)
      flash[:notice] = "Like success"
    else
      flash[:notice] = "Like unsuccess"
    end
    redirect_to repository_path
  end

  def destroy
  end
end