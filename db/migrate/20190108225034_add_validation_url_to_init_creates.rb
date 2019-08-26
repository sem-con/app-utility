class AddValidationUrlToInitCreates < ActiveRecord::Migration[5.2]
  def change
    add_column :init_creates, :validation_url, :string
  end
end
