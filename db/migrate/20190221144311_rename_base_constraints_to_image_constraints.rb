class RenameBaseConstraintsToImageConstraints < ActiveRecord::Migration[5.2]
  def change
    rename_column :init_creates, :base_constraints, :image_constraints
  end
end
