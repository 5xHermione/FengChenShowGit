class AddColumnToUserGithubLogin < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :uid, :integer
    add_column :users, :provider, :string
  end
end
