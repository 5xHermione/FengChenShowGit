class ApplicationController < ActionController::Base
  include MarkdownHelper
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_repository, :find_user

  def configure_permitted_parameters
    # 相關資訊：https://www.rubydoc.info/github/plataformatec/devise/Devise/ParameterSanitizer
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image])
  end

  private
  def current_repository
    @current_repo ||= find_user.repositories.find_by(title: session[:repository_title])
  end

  # 這個名字沒有很好
  def find_user
    @user ||= User.find_by(name: params[:user_name])
  end

  def repositories_order
    find_user.repositories.order("id DESC")
  end

  def set_repo_file_path
    # set git server path and repo path
    user_name = find_user.name
    repo_title = current_repository.title
    @base_path = ENV["GIT_SERVER_PATH"]
    @current_repo_path = "/#{user_name}/#{repo_title}"
  end

  def set_git_remote_path
    set_repo_file_path
    @git_file = Git.open("#{@base_path}#{@current_repo_path}")
  end
end
