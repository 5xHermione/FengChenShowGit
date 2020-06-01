class PullRequestsController < ApplicationController
  before_action :set_pull_request, only: [:show, :edit, :update, :commits]
  before_action :set_git_remote_path, only: [:new, :show, :create, :index, :commits]

  def index
    @pull_requests = current_repository.pull_requests.order("id DESC")
    @pull_request_able = @git_file.branches.remote.map{|b| b.name }.select{|b| `git -C #{@base_path}#{@current_repo_path}.git diff #{@default_branch}...#{b}`.present?}
  end

  def new
    @pull_request = current_repository.pull_requests.new
    @pull_request.name = params[:branch]
    @pull_request.commits = `git -C #{@base_path}#{@current_repo_path}.git log #{@pull_request.repository.default_branch}..#{params[:branch]}`.split("commit").select{ |c| c.length > 1 }.map{ |c| c[1..40]}
    @commits = @pull_request.commits.map{ |sha| @git_file.gcommit(sha)}
  end

  def create
    @pull_request = Repository.find_by(slug: params[:repository_id]).pull_requests.build(pull_request_params)
    @pull_request.repository_pull_request_index = current_repository.pull_requests.count + 1
    @pull_request.commits = `git -C #{@base_path}#{@current_repo_path}.git log #{@pull_request.repository.default_branch}..#{params[:branch]}`.split("commit").select{ |c| c.length > 1 }.map{ |c| c[1..40]}
    @pull_request.compare_branch = params[:branch]
    
    if @pull_request.save 
      redirect_to repository_pull_requests_path(user_name: current_user.name), notice: 'You have created a pull request！' 
    else
      render :new
    end
  end

  def show
    @commits = @pull_request.commits.map{ |sha| @git_file.gcommit(sha)}
    @comments = @pull_request.comments
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @pull_request.update(pull_request_params)
      redirect_to repository_pull_requests_path(user_name: current_user.name), notice: "This pull request has updated."
    else
      render :edit
    end
  end

  def commits
    @commits = @pull_request.commits.map{ |sha| @git_file.gcommit(sha)}
  end

  private
  def pull_request_params
    params.require(:pull_request).permit(:name, :description)
  end

  def set_pull_request
    @pull_request = PullRequest.find(params[:id])
  end
end