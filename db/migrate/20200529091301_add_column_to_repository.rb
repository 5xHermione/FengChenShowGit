class AddColumnToRepository < ActiveRecord::Migration[6.0]
  def change
    add_column :repositories, :default_branch, :string, default: 'master'
  end
end
