class CreateDataFormats < ActiveRecord::Migration[5.2]
  def change
    create_table :data_formats do |t|
      t.string :key_id
      t.text :input_data
      t.text :data_constraints
      t.boolean :validation

      t.timestamps
    end
  end
end
