class CreatePlatformScripts < ActiveRecord::Migration[7.0]
  def change
    create_table :platform_scripts do |t|
      t.references :script, null: false, foreign_key: true
      t.string :platform
      t.text :output
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
