class HomeController < ApplicationController
  helper_method :resource_name, :resource, :devise_mapping
  
  def index
    if user_signed_in?
      @repositories = current_user.repositories
      redirect_to logined_path(current_user.name)
    end
  end

  def logined
    if user_signed_in? && User.find_by(name: params[:user_name])
      @repositories = current_user.repositories
    else
      redirect_to root_path, notice: 'Please login first.'
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end