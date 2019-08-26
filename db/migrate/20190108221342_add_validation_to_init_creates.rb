class AddValidationToInitCreates < ActiveRecord::Migration[5.2]
  def change
    add_column :init_creates, :init_trig, :text
    add_column :init_creates, :base_constraints, :text
    add_column :init_creates, :validation, :boolean
  end
end
