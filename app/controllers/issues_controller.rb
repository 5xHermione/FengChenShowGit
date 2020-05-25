class IssuesController < ApplicationController 
  
  before_action :set_issue, only: [:show, :edit, :update]
  
  def index
    @issues = list_issues
    #資料來源kaminari: https://github.com/kaminari/kaminari  page(params[:page]).per(5)  25筆切換一頁
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Repository.find_by(slug: params[:repository_id]).issues.build(issue_params)
    @issue.repository_issue_index = current_repository.issues.count + 1
    
    if @issue.save 
      redirect_to repository_issues_path, notice: 'You have created an issue！' 
    else
      render :new
    end

  end

  def show
    @comments = @issue.comments
    @comment = @issue.comments.new
  end

  def edit

  end

  def toggle_status
    
    issue = Issue.find(params[:id])
    issue.toggle_status
    issue.save

    if issue.toggle_status == 'open'
      notice = {notice: "This issue has closed!"}
    else 
      notice = {notice: "This issue has opened!"}
    end
    redirect_to repository_issue_path, flash: notice
  end


  def update

    if @issue.update(issue_params)
      flash[:notice] = "This issue has updated."
      redirect_to repository_issue_path(user_name: find_user.name, 
                                        repository_id: @issue.repository.title,
                                        id: @issue.id)
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

  def list_issues
    params[:status] = "open" if params[:status].blank?
    issues_sql = current_repository.issues
                                   .where(status: params[:status])
                                   .order("id DESC")
    if params[:search]
      issues_sql = issues_sql.where('name LIKE ?', "%#{params[:search]}%")
    end
    issues_sql.page(params[:page]).per(5)
  end
end


