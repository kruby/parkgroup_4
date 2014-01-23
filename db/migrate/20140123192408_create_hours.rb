class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.string :description
      t.decimal :number
      t.date :date
      t.integer :user_id
      t.integer :relation_id

      t.timestamps
    end
  end
end
