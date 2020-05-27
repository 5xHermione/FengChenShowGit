class SshkeysController < ApplicationController
  def new
    @sshkey = Sshkey.new
  end

  def create
    @sshkey = current_user.sshkeys.build(ssh_key_params)
    if @sshkey.save
      update_authorized_keys
      redirect_to edit_user_registration_path, notice: "New SSH key is added!"
    else
      render :new
    end
  end

  def destroy
    Sshkey.find(params[:id]).destroy
    update_authorized_keys
    redirect_to edit_user_registration_path, notice: "The SSH key is deleted!"
  end

  private
  def ssh_key_params
    params.require(:sshkey).permit(:name, :key)
  end

  def update_authorized_keys
    #save ssh key to authorized keys
    authorized_keys_file = File.open(ENV["AUTHORIZED_KEYS_PATH"])
    File.write(authorized_keys_file, "", mode: "w")
    Sshkey.all.each do |ssh|
      File.write(authorized_keys_file, "#{ssh.key}\n", mode: "a")
    end
  end
end
