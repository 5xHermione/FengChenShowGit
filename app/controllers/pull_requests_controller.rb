class PullRequestsController < ApplicationController
  def index
    @pull_requests = current_repository.pull_requests.order("id DESC")
  end
end