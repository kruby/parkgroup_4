module ApplicationHelper
	
  def nice_date datoen
      return datoen.strftime('%d.%m.%Y')
  end
  
  def route_exists path
    @r = Rails.application.routes.recognize_path(path)
    @r == nil ? true : false
  end
  
  def delimiter number
    number_with_delimiter(number.to_d, :locale => :da)
  end
  
  
end
