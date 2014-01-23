class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :description
      t.integer :user_id
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at

      t.timestamps
    end
  end
end
