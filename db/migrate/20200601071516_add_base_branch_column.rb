class AddBaseBranchColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :pull_requests, :base_branch, :string, default: 'master'
  end
end
