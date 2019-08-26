class RenameValidInUsageMatch < ActiveRecord::Migration[5.2]
  def change
    remove_column :usage_matches, :valid
    add_column :usage_matches, :match_valid, :boolean    
  end
end
