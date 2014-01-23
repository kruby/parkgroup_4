class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.string :title
      t.text :body
      t.boolean :active, :default => nil

      t.timestamps
    end
  end
end
