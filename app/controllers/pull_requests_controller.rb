class PullRequestsController < ApplicationController
  before_action :set_pull_request, only: [:show, :edit, :update]

  def index
    @pull_requests = current_repository.pull_requests.order("id DESC")
  end

  def new
    @pull_request = PullRequest.new
  end

  def create
    @pull_request = Repository.find_by(slug: params[:repository_id]).pull_requests.build(pull_request_params)
    @pull_request.repository_pull_request_index = current_repository.pull_requests.count + 1
    
    if @pull_request.save 
      redirect_to repository_pull_requests_path(user_name: current_user.name), notice: 'You have created a pull request！' 
    else
      render :new
    end
  end

  def show
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

  private
  def pull_request_params
    params.require(:pull_request).permit(:name, :description)
  end

  def set_pull_request
    @pull_request = PullRequest.find(params[:id])
  end
end