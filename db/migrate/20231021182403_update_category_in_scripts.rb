class UpdateCategoryInScripts < ActiveRecord::Migration[7.0]
  def change
    remove_column :scripts, :category, :integer, null: false
    add_reference :scripts, :category, index: true
  end
end
