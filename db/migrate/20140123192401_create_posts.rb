class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :author
      t.integer :priority
      t.integer :parent_id
      t.integer :user_id
      t.boolean :active

      t.timestamps
    end
  end
end
