class CreateContexts < ActiveRecord::Migration[7.0]
  def change
    create_table :contexts do |t|
      t.references :category, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
