class AddCallToActionToScripts < ActiveRecord::Migration[7.0]
  def change
    add_column :scripts, :call_to_action, :string
  end
end
