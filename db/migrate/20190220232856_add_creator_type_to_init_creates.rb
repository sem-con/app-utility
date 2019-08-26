class AddCreatorTypeToInitCreates < ActiveRecord::Migration[5.2]
  def change
    add_column :init_creates, :creator_type, :string
  end
end
