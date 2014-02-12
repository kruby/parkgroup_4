class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :name
      t.string :address
      t.string :postno
      t.string :city
      t.text :log
      t.string :category
      t.string :responsible
      t.text :info
      t.datetime :next_action
      t.integer :lock_version
      t.integer :user_id
      t.integer :search_lock
      t.string :phone
      t.string :email
      t.string :homepage

      t.timestamps
    end
  end
end
