class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.string :description
      t.decimal :number
      t.integer :partner_id
      t.date :date
      t.integer :user_id
      t.integer :hourly_rate

      t.timestamps
    end
  end
end
