class AddUserSshKey < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :ssh_key, :string
  end
end
