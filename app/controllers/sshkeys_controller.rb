class SshkeysController < ApplicationController
  def new
    @sshkey = Sshkey.new
  end

  def create
    @sshkey = User.find(current_user.id).sshkeys.build(ssh_key_params)
    if @sshkey.save
      redirect_to edit_user_registration_path, notice: "New SSH key is added!"
    else
      render :new
    end
  end

  def destroy
    
  end

  private
  def ssh_key_params
    params.require(:sshkey).permit(:name, :key)
  end
end
