class IssuesController < ApplicationController 
  def index
    @issues = current_repository.issues
  end
end