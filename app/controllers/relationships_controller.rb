class RelationshipsController < ApplicationController
  # 參考自：https://dev.to/knheidorn/rails-crash-course-building-follower-following-relationship-4kjl
  def index
    @active_relationships = find_user.active_relationships
    @passive_relationships = find_user.passive_relationships
  end

  def create
    @followed_user = User.find_by(name: params[:user_name])
    @relationship = current_user.active_relationships.new(followed_id: @followed_user.id)
    if @relationship.save
      flash[:notice] = "Follow Successful"
    else
      flash[:notice] = "Follow Unsuccessful"
    end
    redirect_to root_path
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    if @relationship.follower_user == current_user
      @relationship.destroy
      flash[:notice] = "Unfollowed"
    end
    redirect_to root_path
  end

end