class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :address
      t.string :postno
      t.string :city
      t.text :log
      t.string :description
      t.text :log
      t.string :phone
      t.string :email
      t.integer :partner_id

      t.timestamps
    end
  end
end
