class IssuesController < ApplicationController 
  
  before_action :set_issue, only: [:show, :edit, :update]

  def index
    @issues = current_repository.issues
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Repository.find_by(title: params[:repository_id]).issues.build(issue_params)

    if @issue.save 
      redirect_to repository_issues_path, notice: 'You have created an issue！' 
    else
      render :new
    end

  end

  def show

  end

<<<<<<< HEAD
  end

=======
>>>>>>> issue開關初階段完成&issue路經修改調整
  def edit

  end

  def toggle_status
    
    issue = Issue.find(params[:id])
    issue.toggle_status
    issue.save
<<<<<<< HEAD
    if issue.toggle_status == 'Open'
      redirect_to repository_issue_path, flash: {notice: "This issue has closed!"}
    else issue.toggle_status == "Close"
      redirect_to repository_issue_path, flash: {notice: "This issue has opened again!"}
=======
    if issue.toggle_status == :publish
      redirect_to repository_issue_path, flash: {notice: "This issue has opened again!"}
    else issue.toggle_status == :close
      redirect_to repository_issue_path, flash: {notice: "This issue has closed!"}
>>>>>>> issue開關初階段完成&issue路經修改調整
    end

  end

  def update

    if @issue.update(issue_params)
      flash[:notice] = "This issue has updated."
      redirect_to repository_issue_path(@issue.repository, @issue)
    else
      render edit
  end
  
end

<<<<<<< HEAD

=======
>>>>>>> issue開關初階段完成&issue路經修改調整
  private
  
  def issue_params
    clean_params = params.require(:issue).permit(:name, :description)
  end

  def set_issue
    @issue = Issue.find(params[:id])
  end

end