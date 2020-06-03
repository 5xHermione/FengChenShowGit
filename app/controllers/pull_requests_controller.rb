class PullRequestsController < ApplicationController
  before_action :set_pull_request, only: [:show, :edit, :update, :commits]
  before_action :set_git_remote_path, only: [:new, :show, :create, :index, :commits, :compare, :diff]

  def index
    @pull_requests = current_repository.pull_requests.order("id DESC")
    @pull_request_able = @git_file.branches.remote.map{|b| b.name }.select{|b| `git -C #{@base_path}#{@current_repo_path}.git diff #{@default_branch}...#{b}`.present? && PullRequest.find_by(compare_branch: b).nil?}
  end

  def compare
    @pull_request = PullRequest.new
    @branches = @git_file.branches.remote
  end

  def diff
    @base_branch = params[:pull_request][:base_branch]
    @compare_branch = params[:pull_request][:compare_branch]
    diff_pr = DiffPullRequest.new("#{@base_path}#{@current_repo_path}.git")
    diff_pr.set_base_branch(@base_branch)
    diff_pr.set_compare_branch(@compare_branch)
    @diff_files = []
    diff_pr.changed_file_name.each do |file_name|
     @diff_files << diff_pr.diff_in_files(file_name)
    end
    if @diff_files == []
      redirect_to compare_repository_pull_requests_path(user_name: find_user.name), notice: 'These two branches has no difference, please choose other branches.'
    else
      
    end
  end

  def new
    @branches = @git_file.branches.remote
    @pull_request = current_repository.pull_requests.new
    @pull_request.name = params[:compare_branch]
    @pull_request.commits = `git -C #{@base_path}#{@current_repo_path}.git log #{params[:base_branch]}..#{params[:compare_branch]}`.split("commit").select{ |c| c.length > 1 }.map{ |c| c[1..40]}
    @pull_request.base_branch = params[:base_branch] 
    @pull_request.compare_branch = params[:compare_branch]
    @commits = @pull_request.commits.map{ |sha| @git_file.gcommit(sha)}

    #diff files
    diff_pr = DiffPullRequest.new("#{@base_path}#{@current_repo_path}.git")
    diff_pr.set_base_branch(@pull_request.base_branch)
    diff_pr.set_compare_branch(@pull_request.compare_branch)
    @diff_files = []
    diff_pr.changed_file_name.each do |file_name|
     @diff_files << diff_pr.diff_in_files(file_name)
    end
    byebug
  end

  def create
    @pull_request = find_user.repositories.find_by(slug: params[:repository_id]).pull_requests.build(pull_request_params)
    @pull_request.repository_pull_request_index = current_repository.pull_requests.count + 1
    @pull_request.commits = `git -C #{@base_path}#{@current_repo_path}.git log #{@pull_request.repository.default_branch}..#{params[:compare_branch]}`.split("commit").select{ |c| c.length > 1 }.map{ |c| c[1..40]}
    @pull_request.compare_branch = params[:compare_branch]
    @pull_request.base_branch = params[:base_branch]

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
