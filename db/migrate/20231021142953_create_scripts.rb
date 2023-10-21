class CreateScripts < ActiveRecord::Migration[7.0]
  def change
    create_table :scripts do |t|
      t.integer :category, null: false
      t.integer :context, null: false
      t.integer :duration, null: false
      t.integer :mood, null: false
      t.integer :status, null: false, default: 0
      t.string :description
      t.text :output
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
