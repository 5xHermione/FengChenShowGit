class IssuesController < ActionController::Base
  def index
    @issues = current_user.repositories.find_by(title: repository_params[:title])
  end
end