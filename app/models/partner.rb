class Partner < ActiveRecord::Base
	
	has_many :contacts
	has_many :hours
	has_many :vouchers
	
end
