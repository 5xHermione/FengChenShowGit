class HomeController < ApplicationController
  helper_method :resource_name, :resource, :devise_mapping
  
  def index
    if user_signed_in?
      @repositories = current_user.repositories.order("id DESC")
      @users = User.all.order("RANDOM()").limit(5)

      redirect_to logged_in_path(current_user.name)
    end
  end

  def logged_in
    if user_signed_in?
      if current_user == find_user
        @repositories = repositories_order
      else
        @repositories = repositories_order.select{ |repo| repo.is_public == true }
      end
      @user = find_user
      @users = User.all.order("RANDOM()").limit(5)
    else
      redirect_to root_path, notice: 'Please login first.'
    end
  end

  # 這三個方法來自 devise ，使用在首頁的註冊及登入表單
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