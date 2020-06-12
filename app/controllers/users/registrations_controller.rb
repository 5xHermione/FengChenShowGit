class Users::RegistrationsController < Devise::RegistrationsController

  def update
    old_user_name = current_user.name
    super
    logger.info `mv #{ENV["GIT_SERVER_PATH"]}/#{old_user_name} #{ENV["GIT_SERVER_PATH"]}/#{params[:user][:name]}`
    current_user.repositories.to_a.each do |repo|
      logger.info "git -C #{ENV["GIT_SERVER_PATH"]}/#{params[:user][:name]}/#{repo.title} remote set-url origin #{ENV["GIT_PUSH_INSTRUCT"]}/#{params[:user][:name]}/#{repo.title}.git"
      logger.info `git -C #{ENV["GIT_SERVER_PATH"]}/#{params[:user][:name]}/#{repo.title} remote set-url origin #{ENV["GIT_PUSH_INSTRUCT"]}/#{params[:user][:name]}/#{repo.title}.git`
    end
  end

end
