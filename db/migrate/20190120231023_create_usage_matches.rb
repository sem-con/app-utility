class CreateUsageMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :usage_matches do |t|
      t.string :key_id
      t.text :data_subject
      t.text :data_controller
      t.boolean :valid

      t.timestamps
    end
  end
end
