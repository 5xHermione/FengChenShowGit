class ChargePullRequestColumnDefaultValue < ActiveRecord::Migration[6.0]
  def change
    remove_column :pull_requests, :status
    add_column :pull_requests, :status, :string, default: 'Open'
  end
end
