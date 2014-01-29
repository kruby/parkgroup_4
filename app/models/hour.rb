class Hour < ActiveRecord::Base
  belongs_to :relation
  belongs_to :user
  
  #default_scope order('relation_id DESC, date DESC')
  default_scope { order('relation_id DESC, date DESC') }        
  
  #scope :timeliste, lambda { |relation_id| where(:relation_id => relation_id) }
  scope :timeliste, ->(relation_id) {where(relation_id: relation_id)}
  
  #scope :customer, lambda { |relation_id| where(:relation_id => relation_id) }
  scope :customer, ->(relation_id) {where(relation_id: relation_id)}
  
  #scope :month_hours, lambda { |this_month| where("date BETWEEN '#{this_month.to_datetime.beginning_of_month}' AND '#{this_month.to_datetime.end_of_month}'") }
  scope :month_hours, ->(this_month) {where("date BETWEEN '#{this_month.to_datetime.beginning_of_month}' AND '#{this_month.to_datetime.end_of_month}'") }
  
  #scope :year_hours, lambda { |this_year| where("date BETWEEN '#{this_year.to_datetime.beginning_of_year}' AND '#{this_year.to_datetime.end_of_year}'") }
  scope :year_hours, ->(this_year) {where("date BETWEEN '#{this_year.to_datetime.beginning_of_year}' AND '#{this_year.to_datetime.end_of_year}'")}
  
  
  #scope :last_year_first_6_months, lambda { |this_date| where("date BETWEEN '#{this_date.to_datetime.beginning_of_year}' AND '#{this_date.to_datetime.beginning_of_year+6.months-1.day}'") }
  scope :last_year_first_6_months, ->(this_date) {where("date BETWEEN '#{this_date.to_datetime.beginning_of_year}' AND '#{this_date.to_datetime.beginning_of_year+6.months-1.day}'")}
  #scope :last_year_last_6_months, lambda { |this_date| where("date BETWEEN '#{this_date.to_datetime.beginning_of_year+6.months}' AND '#{this_date.to_datetime.end_of_year}'")}
  scope :last_year_last_6_months, ->(this_date) {where("date BETWEEN '#{this_date.to_datetime.beginning_of_year+6.months}' AND '#{this_date.to_datetime.end_of_year}'")}
  
  
  #scope :this_year_last_6_months, lambda { |this_date| where("date BETWEEN '#{this_date.to_datetime.beginning_of_year+6.months}' AND '#{this_date.to_datetime.end_of_year}'") }
  scope :this_year_last_6_months, ->(this_date) {where("date BETWEEN '#{this_date.to_datetime.beginning_of_year+6.months}' AND '#{this_date.to_datetime.end_of_year}'")}
  #scope :this_year_first_6_months, lambda { |this_date| where("date BETWEEN '#{this_date.to_datetime.beginning_of_year}' AND '#{this_date.to_datetime.beginning_of_year+6.months-1.day}'") }
  scope :this_year_first_6_months, ->(this_date) {where("date BETWEEN '#{this_date.to_datetime.beginning_of_year}' AND '#{this_date.to_datetime.beginning_of_year+6.months-1.day}'")}
  
  #scope :last_3_years, lambda { |this_date| where("date BETWEEN '#{this_date.to_datetime.beginning_of_year-3.years}' AND '#{this_date.to_datetime.end_of_year}'") }
  scope :last_3_years, ->(this_date) {where("date BETWEEN '#{this_date.to_datetime.beginning_of_year-3.years}' AND '#{this_date.to_datetime.end_of_year}'")}
end
