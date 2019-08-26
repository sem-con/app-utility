class AddDataCategoryToUsageCreates < ActiveRecord::Migration[5.2]
  def change
    add_column :usage_creates, :data_category, :text
  end
end
