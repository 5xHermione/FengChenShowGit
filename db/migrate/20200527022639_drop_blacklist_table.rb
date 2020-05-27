class DropBlacklistTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :blacklists
  end
end
