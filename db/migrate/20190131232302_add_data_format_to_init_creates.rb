class AddDataFormatToInitCreates < ActiveRecord::Migration[5.2]
  def change
    add_column :init_creates, :data_format, :string
  end
end
