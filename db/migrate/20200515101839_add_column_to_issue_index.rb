class AddColumnToIssueIndex < ActiveRecord::Migration[6.0]
  def change
    add_column :issues, :repository_issue_index, :integer
  end
end
