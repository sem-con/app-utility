class AddUsagePolicyToUsageCreates < ActiveRecord::Migration[5.2]
  def change
    add_column :usage_creates, :usage_policy, :text
  end
end
