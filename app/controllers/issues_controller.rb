class IssuesController < ApplicationController 
  def index
    @issues = current_user.repositories.find_by(params[:repository_title]).issues
    p "----------------"
    p @issues
    p "----------------------"
  end
end