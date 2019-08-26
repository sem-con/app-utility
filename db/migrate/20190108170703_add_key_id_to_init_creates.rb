class AddKeyIdToInitCreates < ActiveRecord::Migration[5.2]
  def change
    add_column :init_creates, :key_id, :string
  end
end
