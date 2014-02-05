class ChangeFieldCategoryInContents < ActiveRecord::Migration
	def up
		change_column :contents, :category, :string, default: 'Admin'
	end

	def down
		change_column :contents, :category, :string
	end
end
