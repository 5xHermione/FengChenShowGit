class AddDiffContentsToPullRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :pull_requests, :diff, :json
  end
end
