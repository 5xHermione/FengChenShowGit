class CommentsController < ApplicationController
  def create
    if params[:pull_request_id]
      @comment = PullRequest.find(params[:pull_request_id].to_i).comments.build(comment_params)
    else
      @comment = Issue.find(params[:issue_id].to_i).comments.build(comment_params)
    end

    @comment.user_id = current_user.id
    
    if @comment.save
      flash[:notice] = 'You have created a comment.'
    else
      flash[:notice] = 'something wrong.'
    end
    redirect_to repository_pull_request_path(id: params[:pull_request_id])
  end

  def update
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end