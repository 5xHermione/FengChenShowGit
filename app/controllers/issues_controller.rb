class IssuesController < ApplicationController 
  
  before_action :set_issue, only: [:show, :edit, :update]

  def index
    @issues = current_repository.issues
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Repository.find_by(id: params[:repository_id]).issues.build(issue_params)

    if @issue.save 
      redirect_to repository_issues_path, notice: '已建立新專案！' 
    else
      render :new
    end

  end

  def show
    
    
  end


  def edit
   
    # byebug
  end

  def update
   
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

  def set_issue
    @issue = Issue.find(params[:id])
  end

 

end