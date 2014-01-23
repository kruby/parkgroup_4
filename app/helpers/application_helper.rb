module ApplicationHelper
	
  def nice_date datoen
      return datoen.strftime('%d.%m.%Y')
  end
  
  def route_exists path
    @r = Rails.application.routes.recognize_path(path)
    @r == nil ? true : false
  end
  
end
