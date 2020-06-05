class AddReferenceToPullRequestAndUser < ActiveRecord::Migration[6.0]
  def change
    add_column :pull_requests, :user_id, :integer
    add_index :pull_requests, :user_id
  end
end
