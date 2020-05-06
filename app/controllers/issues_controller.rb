class IssuesController < ApplicationController 
  def index
    @issues = current_repository.issues
  end

  private
  def current_repository
    current_user.repositories.find_by(title: params[:repository_title])
  end
end