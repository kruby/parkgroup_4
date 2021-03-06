class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :attachable_type
      t.integer :attachable_id
      t.string :description
      t.string :image_size
      t.integer :priority
      t.integer :asset_id

      t.timestamps
    end
  end
end
