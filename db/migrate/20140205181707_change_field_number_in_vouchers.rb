class ChangeFieldNumberInVouchers < ActiveRecord::Migration
  def up
    change_column :vouchers, :number, :decimal, precision: 10, scale: 2
  end  

  def down
    change_column :vouchers, :number, :decimal
  end  
end
