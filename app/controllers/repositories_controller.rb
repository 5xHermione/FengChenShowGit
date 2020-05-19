class RepositoriesController < ApplicationController
  before_action :set_repository, only: [:show, :edit, :update, :destroy]
  before_action :set_request_format 
  def index
    if current_user
      @repositories = current_user.repositories.order("id DESC").includes(:user)
    else
      redirect_to new_user_session_path
    end
  end

  def show
    # @is_new_repo = true
    #set base path and repo path
    user_name = @repository.user.name
    repo_title = @repository.title
    @base_path = ENV["GIT_SERVER_PATH"]
    @current_repo_path = "/#{user_name}/#{repo_title}"


    #synchronize git working repo 
    `git -C #{@base_path}#{@current_repo_path} pull`
    


    # to a method path
    #set directory path
    @path = request.original_fullpath
    if @path.match(/\/repositories\/.+\/worktree\/master\/(.+)/)
      @path = "#{@base_path}#{@current_repo_path}"+"/"+@path.match(/\/repositories\/.+\/worktree\/master\/(.+)/)[1]
    else
      @path = "#{@base_path}#{@current_repo_path}/."
    end

    @files = []
    @dirs = []

    @is_file = File.file?(@path)

    if @is_file
      @file_data = File.read(@path)
    else
      Dir.entries(@path).each do |file|
        if [".", "..", ".git"].include?"#{file}"
        #rule out ".", "..", ".git"
        elsif File.file?(@path+"/"+file)
          @files << "#{@path.match(/^#{@base_path}#{@current_repo_path}\/(.+)/)[1]}/#{file}"
        else
          @dirs << "#{@path.match(/^#{@base_path}#{@current_repo_path}\/(.+)/)[1]}/#{file}"
        end
      end
    end
  end

  def new
    @repository = Repository.new
  end

  def edit
  end

  def create
    @repository = current_user.repositories.new(repository_params)
    @repository.errors.add(:is_public, "must select one") if params[:is_public].nil?


    if @repository.errors.any?
      render :new
    else
      if @repository.save
        title = @repository.title
        bare_repo_dir = "#{title}.git"

        full_dir = "#{ENV["GIT_SERVER_PATH"]}/#{current_user.name}/#{bare_repo_dir}"
        working_dir = "#{ENV["GIT_SERVER_PATH"]}/#{current_user.name}/#{title}"

        #新增一個空的資料夾
        `mkdir -p #{full_dir}`
        #在剛剛新增的空資料夾中建立一個 bare repo
        #bare repo 可以被push clone
        #bare repo 中是沒有檔案的
        `git --bare init #{full_dir}`
        #要讓網頁可以使用檔案、可以 commit 、需要的是 working repo （也就是我們平常 git init 之後的創造出來的 git 目錄）
        # 從 bare repo 中 clone 出一個 working repo，讓我們有檔案可以處理
        `git clone #{full_dir}  #{working_dir}`
        redirect_to repositories_path, notice: 'You have created a repository.' 
      else
        render :new
      end
    end
  end

  def update
    if @repository.update(repository_params)
      redirect_to repositories_path, notice: 'This repository has updated.'
    else
      render :edit
    end
  end

  def destroy
    @repository.destroy
    redirect_to repositories_path, notice: 'This repository is deleted！'
  end

  private
    def set_repository
      @repository = Repository.friendly.find(params[:id])
      session[:repository_id] = @repository.id
    end

    def repository_params
      params.require(:repository).permit(:title, :description, :user_id, :is_public, :slug)
    end

    def set_request_format
      request.format = :html
    end
end
