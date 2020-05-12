class IssuesController < ApplicationController 
  def index
    @issues = current_repository.issues
  end

  def new
    @issue = Issue.new
  end

  def create
    # @issue = current_user.issues.build(issue_params)
    @issue = Repository.find_by(id: params[:repository_id]).issues.build(issue_params)
    # @issue.update(user_id: current_user.id)
    

    if @issue.save 
      redirect_to repository_issues_path, notice: '已建立新專案！' 
    else
      render :new
    end

  end

  def show
    @issue = Issue.find(params[:id])
    
  end


  def edit
    @issue = Issue.find(params[:id])
    # byebug
  end

  def update
    @issue = Issue.find(params[:id])

    if @issue.update(issue_params)
      flash[:notice] = "issue已更新"
      redirect_to repository_issue_path
    else
      render edit
  end
end


  private
  

  def issue_params
    clean_params = params.require(:issue).permit(:name, :description)
  end



end