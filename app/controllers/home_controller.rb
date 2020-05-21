class HomeController < ApplicationController
  helper_method :resource_name, :resource, :devise_mapping
  
  def index
    if user_signed_in?
      @repositories = current_user.repositories
      @users = User.all.limit(5)

      redirect_to logged_in_path(current_user.name)
    end
  end

  def logged_in
    if user_signed_in? && User.find_by(name: params[:user_name])
      @repositories = User.find_by(name: params[:user_name]).repositories
      @users = User.all.limit(5)
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