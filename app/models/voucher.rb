class Voucher < ActiveRecord::Base
  
  belongs_to :relation
  
  #scope :last_year_first_6_months, lambda { |this_date| where("date BETWEEN '#{this_date.to_datetime.beginning_of_year}' AND '#{this_date.to_datetime.beginning_of_year+6.months-1.day}'") }
  scope :last_year_first_6_months, ->(this_date) {where("date BETWEEN '#{this_date.to_datetime.beginning_of_year}' AND '#{this_date.to_datetime.beginning_of_year+6.months-1.day}'")}
  #scope :last_year_last_6_months, lambda { |this_date| where("date BETWEEN '#{this_date.to_datetime.beginning_of_year+6.months}' AND '#{this_date.to_datetime.end_of_year}'") }
  scope :last_year_last_6_months, ->(this_date) {where("date BETWEEN '#{this_date.to_datetime.beginning_of_year+6.months}' AND '#{this_date.to_datetime.end_of_year}'")}
  
  #scope :this_year_last_6_months, lambda { |this_date| where("date BETWEEN '#{this_date.to_datetime.beginning_of_year+6.months}' AND '#{this_date.to_datetime.end_of_year}'") }
  scope :this_year_last_6_months, ->(this_date) {where("date BETWEEN '#{this_date.to_datetime.beginning_of_year+6.months}' AND '#{this_date.to_datetime.end_of_year}'")}
  #scope :this_year_first_6_months, lambda { |this_date| where("date BETWEEN '#{this_date.to_datetime.beginning_of_year}' AND '#{this_date.to_datetime.beginning_of_year+6.months-1.day}'") }    
  scope :this_year_first_6_months, ->(this_date) {where("date BETWEEN '#{this_date.to_datetime.beginning_of_year}' AND '#{this_date.to_datetime.beginning_of_year+6.months-1.day}'")}
  	
	def self.turnover_total
		self.sum{|v| v.number.to_f * v.hourly_rate.to_f}
	end
	
	def self.hours_total
		self.sum('number') rescue nil
	end
	
	def self.average_hourly_rate
		turnover_total / hours_total
	end
	
  
  
end
