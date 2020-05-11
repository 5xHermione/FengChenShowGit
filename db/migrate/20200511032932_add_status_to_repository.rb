class AddStatusToRepository < ActiveRecord::Migration[6.0]
  def change
    add_column :repositories, :is_public, :boolean, default: false
  end
end
