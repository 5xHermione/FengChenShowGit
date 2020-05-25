class CommentsController < ApplicationController
  def create
    if params[:pull_request_id]
      @comment = PullRequest.find(params[:pull_request_id].to_i).comments.build(comment_params)
      comment_save(@comment)
      redirect_to repository_pull_request_path(id: params[:pull_request_id])
    else
      @comment = Issue.find(params[:issue_id].to_i).comments.build(comment_params)
      comment_save(@comment)
      redirect_to repository_issue_path(id: params[:issue_id])
    end
  end

  def update
  end

  def destroy
    Comment.find(params[:id]).destroy
    if params[:pull_request_id]
      redirect_to repository_pull_request_path(id: params[:pull_request_id])
    else
      redirect_to repository_issue_path(id: params[:issue_id])
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def comment_save(comment)
    comment.user_id = current_user.id
    if comment.save
      flash[:notice] = 'You have created a comment.'
    else
      flash[:notice] = 'something wrong.'
    end
  end
end