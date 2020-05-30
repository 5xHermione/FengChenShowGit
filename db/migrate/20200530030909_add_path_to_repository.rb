class AddPathToRepository < ActiveRecord::Migration[6.0]
  def change
    add_column :repositories, :path, :string
  end
end
