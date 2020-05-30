class CreateSshkeys < ActiveRecord::Migration[6.0]
  def change
    create_table :sshkeys do |t|
      t.string :name
      t.text :key
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
