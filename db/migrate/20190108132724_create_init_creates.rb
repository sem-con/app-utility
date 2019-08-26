class CreateInitCreates < ActiveRecord::Migration[5.2]
  def change
    create_table :init_creates do |t|
      t.string :title
      t.text :description
      t.string :creator_name
      t.string :creator_email
      t.string :contributor_name
      t.string :contributor_email
      t.text :usage_policy
      t.text :data_model
      t.text :data_constraints
      t.text :data_example

      t.timestamps
    end
  end
end
