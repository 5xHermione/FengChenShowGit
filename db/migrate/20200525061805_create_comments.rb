class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :commentable_id, null: false, index: true
      t.string :commentable_type
      t.references :user, null: false, foreign_key: true, index: true
      t.timestamps
    end
  end
end
