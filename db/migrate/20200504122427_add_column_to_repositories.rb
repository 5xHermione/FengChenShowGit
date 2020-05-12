class AddColumnToRepositories < ActiveRecord::Migration[6.0]
  def change
    add_column :repositories, :user_id, :integer 
    add_index :repositories, :user_id
  end
end
