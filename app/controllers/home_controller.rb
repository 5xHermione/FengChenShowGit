class HomeController < ApplicationController
  helper_method :resource_name, :resource, :devise_mapping, :resource_class
  
  def index
    if user_signed_in?
      @repositories = current_user.repositories.order("id DESC")
      @users = User.all.order("RANDOM()").limit(5)

      redirect_to logged_in_path(current_user.name)
    end
  end

  def verification
    @verification = User.where(name: params[:name]).or(User.where(email: params[:email])).exists?
    respond_to do |format|
      format.json { render json: !@verification }
    end 
  end

  def logged_in
    if user_signed_in?
      if current_user == find_user
        @repositories = repositories_order
      else
        @repositories = repositories_order.select{ |repo| repo.is_public == true }
      end
      @users = User.where("id != ?", current_user.id).order("RANDOM()").limit(10)
    else
      redirect_to root_path, notice: 'Please login first.'
    end
  end

  # 這四方法來自 devise ，使用在首頁的註冊及登入表單
  def resource_class
    devise_mapping.to
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