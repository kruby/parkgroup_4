class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.integer :resource_id
      t.string :resource_type
      t.integer :parent_id
      t.string :navlabel
      t.boolean :active
      t.boolean :redirect
      t.string :controller_redirect
      t.string :action_redirect
      t.integer :position
      t.string :controller_name
      t.string :category

      t.timestamps
    end
  end
end
