class RelationshipsController < ApplicationController
  def index
    @active_relationships = find_user.active_relationships
    @passive_relationships = find_user.passive_relationships
  end

  def create
    byebug
    @followed_user = User.find(params[:relationship][:followed_user])
    @relationship = current_user.active_relationships.new(followed_id: @followed_user.id)
    if @relationship.save
      flash[:notice] = "Follow Successful"
    else
      flash[:notice] = "Follow Unsuccessful"
    end
    redirect_to logged_in_path
  end

  def destroy
  end
end