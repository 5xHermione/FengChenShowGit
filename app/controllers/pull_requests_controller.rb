class PullRequestsController < ApplicationController
  before_action :set_pull_request, only: [:show, :edit, :update, :commits, :files_changed, :merge, :close, :reopen]
  before_action :set_git_remote_path, only: [:new, :show, :create, :index, :commits, :compare, :diff, :files_changed, :merge]

  def index
    @pull_requests = current_repository.pull_requests.order("id DESC")
    @pull_request_able = @git_file.branches.remote.map{|b| b.name }.select{|b| `git -C #{@base_path}#{@current_repo_path}.git diff #{@default_branch}...#{b}`.present? && current_repository.pull_requests.find_by(compare_branch: b).nil?}
  end

  def close_index
    @pull_requests = current_repository.pull_requests.order("id DESC")
  end

  def compare
    @pull_request = PullRequest.new
    @branches = @git_file.branches.remote
  end

  def diff
    @base_branch = params[:pull_request][:base_branch]
    @compare_branch = params[:pull_request][:compare_branch]
    @diff_files = diff_in_files(@base_branch, @compare_branch)
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
    @base_branch = params[:base_branch] 
    @compare_branch = params[:compare_branch]
    @commits = @pull_request.commits.map{ |sha| @git_file.gcommit(sha)}
    @pull_request.diff = diff_in_files(@base_branch, @compare_branch)
  end

  def create
    @pull_request = find_user.repositories.find_by(slug: params[:repository_id]).pull_requests.build(pull_request_params)
    @pull_request.user = current_user
    @pull_request.repository_pull_request_index = current_repository.pull_requests.count + 1
    @pull_request.commits = `git -C #{@base_path}#{@current_repo_path}.git log #{@pull_request.repository.default_branch}..#{params[:compare_branch]}`.scan(/\w+/).select{ |word| word.length == 40 }
    @pull_request.compare_branch = params[:compare_branch]
    @pull_request.base_branch = params[:base_branch]
    @pull_request.diff = diff_in_files(@pull_request.base_branch, @pull_request.compare_branch)

    if @pull_request.save 
      redirect_to repository_pull_requests_path(user_name: current_user.name), notice: 'You have created a pull request！' 
    else
      render :new
    end
  end

  def show
    @commits_sha = `git -C #{@base_path}#{@current_repo_path}.git log #{@pull_request.base_branch}..#{@pull_request.compare_branch}`.scan(/\w+/).select{|word| word.length == 40}
    @commits = @commits_sha.map{ |sha| @git_file.gcommit(sha)}
    @comments = @pull_request.comments
    @comment = Comment.new
    @pull_request.commits = @commits_sha

    `git -C #{@base_path}#{@current_repo_path} checkout #{@pull_request.compare_branch}`
    @have_conflicts = `git -C #{@base_path}#{@current_repo_path} merge --no-commit --no-ff #{@pull_request.base_branch}`.scan(/Automatic merge failed; fix conflicts and then commit the result./).present?
    `git -C #{@base_path}#{@current_repo_path} merge --abort`
    `git -C #{@base_path}#{@current_repo_path} checkout #{@pull_request.base_branch}`
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

  def merge
    @pull_request.commits = `git -C #{@base_path}#{@current_repo_path}.git log #{@pull_request.base_branch}..#{@pull_request.compare_branch}`.scan(/\w+/).select{|word| word.length == 40}
    `git -C #{@base_path}#{@current_repo_path} checkout #{@pull_request.base_branch}`
    `git -C #{@base_path}#{@current_repo_path} merge #{@pull_request.compare_branch}`
    @pull_request.status = "Merged"
    @pull_request.save
    `git -C #{@base_path}#{@current_repo_path} push origin #{@pull_request.base_branch}`
    redirect_to repository_pull_request_path(user_name: find_user.name, repository_id: current_repository.title, id: @pull_request), notice: "This pull request has been merged."
  end

  def close
    @pull_request.status = 'Close'
    @pull_request.save
    redirect_to repository_pull_request_path(user_name: find_user.name, repository_id: current_repository.title, id: @pull_request), notice: "This pull request has been closed."
  end

  def reopen
    @pull_request.status = 'Open'
    @pull_request.save
    redirect_to repository_pull_request_path(user_name: find_user.name, repository_id: current_repository.title, id: @pull_request), notice: "This pull request has been opened."
  end

  def files_changed
    if diff_in_files(@pull_request.base_branch, @pull_request.compare_branch) != []
      @pull_request.update_columns(diff: diff_in_files(@pull_request.base_branch, @pull_request.compare_branch))
    end
    @pull_request.diff
  end

  private
  def pull_request_params
    params.require(:pull_request).permit(:name, :description)
  end

  def set_pull_request
    @pull_request = PullRequest.find(params[:id])
  end

  def diff_in_files(base_branch, compare_branch)
    diff_pr = DiffPullRequest.new(
      "#{@base_path}#{@current_repo_path}.git",
      base_branch: base_branch,
      compare_branch: compare_branch
    )
    diff_pr.diff_in_files
  end
end
