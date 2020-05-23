class RepositoriesController < ApplicationController
  before_action :set_repository, only: [:show, :edit, :update, :destroy]
  before_action :set_request_format, only: [:show]

  def index
    if current_user
      if current_user == find_user
        @repositories = repositories_order
        respond_to do |format|
          format.json { render json: @repositories }
          format.html { render :index }
        end
      else
        @repositories = repositories_order.select{ |repo| repo.is_public == true }
        respond_to do |format|
          format.json { render json: @repositories }
          format.html { render :index }
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  def show
    set_repo_file_path

    # synchronize git working repo 
    `git -C #{@base_path}#{@current_repo_path} pull`

    if Dir.entries("#{@base_path}#{@current_repo_path}") == [".", "..", ".git"]
      is_new_repo = true 
    else
      is_new_repo = false
    end
    
    # get folder path from url
    path = request.original_fullpath
    if path.match(/\/repositories\/.+\/worktree\/master\/(.+)/)
      path = "#{@base_path}#{@current_repo_path}"+"/"+path.match(/\/repositories\/.+\/worktree\/master\/(.+)/)[1]
    else
      path = "#{@base_path}#{@current_repo_path}/."
    end

    files = []
    dirs = []

    is_file = File.file?(path)
    
    if is_new_repo && current_user == find_user
      render :how_to_push
    elsif is_new_repo && current_user != find_user
        render :empty_repo
    elsif is_file
      file_data = File.read(path)
      render :file , locals: {file_data: file_data}
    else
      Dir.entries(path).each do |file|
        if [".", "..", ".git"].include?"#{file}"
        #rule out ".", "..", ".git"
        elsif File.file?(path+"/"+file)
          files << "#{path.match(/^#{@base_path}#{@current_repo_path}\/(.+)/)[1]}/#{file}"
        else
          dirs << "#{path.match(/^#{@base_path}#{@current_repo_path}\/(.+)/)[1]}/#{file}"
        end
      end
      render :dir, locals: {dirs: dirs, files: files, repository: @repository}
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
      @repository.is_public = params[:is_public]
      if @repository.save
        set_repo_file_path

        full_dir = "#{@base_path}/#{@current_repo_path}.git"
        working_dir = "#{@base_path}/#{@current_repo_path}"

        # 新增一個空的資料夾
        `mkdir -p #{full_dir}`
        # 在剛剛新增的空資料夾中建立一個 bare repo
        #bare repo 可以被push clone
        #bare repo 中是沒有檔案的
        `git --bare init #{full_dir}`
        # 要讓網頁可以使用檔案、可以 commit 、需要的是 working repo （也就是我們平常 git init 之後的創造出來的 git 目錄）
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
      params.require(:repository).permit(:title, :description, :is_public)
    end

    def set_request_format
      request.format = :html
    end

    def set_repo_file_path
      # set git server path and repo path
      user_name = find_user.name
      repo_title = @repository.title
      @base_path = ENV["GIT_SERVER_PATH"]
      @current_repo_path = "/#{user_name}/#{repo_title}"
    end
end
