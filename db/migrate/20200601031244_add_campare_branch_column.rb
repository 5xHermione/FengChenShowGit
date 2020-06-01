class AddCampareBranchColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :pull_requests, :compare_branch, :string
  end
end
