class CreatePullRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :pull_requests do |t|
      t.string :name
      t.text :description
      t.string :status, default: "open"
      t.references :repository, null: false, foreign_key: true

      t.timestamps
    end
  end
end
