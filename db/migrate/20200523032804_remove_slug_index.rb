class RemoveSlugIndex < ActiveRecord::Migration[6.0]
  def change
    remove_index :repositories, :slug
  end
end
