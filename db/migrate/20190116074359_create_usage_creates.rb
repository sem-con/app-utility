class CreateUsageCreates < ActiveRecord::Migration[5.2]
  def change
    create_table :usage_creates do |t|
      t.string :key_id
      t.string :recipient
      t.string :purpose
      t.string :processing
      t.string :storage_location
      t.string :storage_duration

      t.timestamps
    end
  end
end
