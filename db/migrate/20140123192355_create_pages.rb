class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.string :headline
      t.text :body
      t.boolean :active

      t.timestamps
    end
  end
end
