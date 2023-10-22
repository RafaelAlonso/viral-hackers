class AddTargetAudienceToScripts < ActiveRecord::Migration[7.0]
  def change
    add_column :scripts, :target_audience, :string
  end
end
