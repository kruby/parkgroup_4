class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.string :company
      t.string :address
      t.string :postno
      t.string :city
      t.text :log
      t.string :category
      t.string :responsible
      t.text :phone
      t.datetime :next_action
      t.integer :lock_version
      t.integer :user_id
      t.string :type
      t.integer :search_lock
      t.string :homepage
      t.string :email

      t.timestamps
    end
  end
end
