class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.string :name
      t.text :description
      t.string :status
      t.references :repository, null: false, foreign_key: true

      t.timestamps
    end
  end
end
