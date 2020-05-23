class ApplicationController < ActionController::Base
  include MarkdownHelper
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_repository, :find_user
  
  def configure_permitted_parameters
    # 相關資訊：https://www.rubydoc.info/github/plataformatec/devise/Devise/ParameterSanitizer
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private
  def current_repository
    find_user.repositories.find_by(title: session[:repository_title])
  end

  def find_user
    User.find_by(name: params[:user_name])
  end

  def repositories_order
    find_user.repositories.order("id DESC")
  end

end
