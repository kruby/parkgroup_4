class ChangeFieldNumberInHours < ActiveRecord::Migration
  def up
    change_column :hours, :number, :decimal, precision: 10, scale: 2
  end

  def down
    change_column :hours, :number, :integer
  end
end