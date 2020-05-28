class Users::RegistrationsController < Devise::RegistrationsController

  # PUT /resource
  def update
    old_user_name = current_user.name
    super
    `mv #{ENV["GIT_SERVER_PATH"]}/#{old_user_name} #{ENV["GIT_SERVER_PATH"]}/#{params[:user][:name]}`
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

end
