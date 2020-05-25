class RelationshipsController < ApplicationController
  # 參考自：https://dev.to/knheidorn/rails-crash-course-building-follower-following-relationship-4kjl
  def index
    @following_users = find_user.following_users
  end

  def followers
    @followers = find_user.followers
  end

  def create
    followed_user = User.find_by(name: params[:user_name])
    relationship = current_user.active_relationships.new(followed_id: followed_user.id)

    if followed_user == current_user
      redirect_to root_path, notice: "You can't follow yourself!"
    else
      if relationship.save
        redirect_to root_path, notice: "Follow Successful!"
      else
        redirect_to root_path, notice: "Failed to follow!"
      end
    end
  end

  def destroy
    relationship = Relationship.find(params[:id])
    if relationship.follower_user == current_user
      relationship.destroy
      flash[:notice] = "Unfollowed"
    end
    redirect_to root_path
  end

end