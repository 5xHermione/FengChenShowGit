class AddCommitsColumnToPullRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :pull_requests, :commits, :string, array: true
  end
end
