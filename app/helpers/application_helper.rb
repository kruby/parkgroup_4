module ApplicationHelper
	#KIG EFTER DATOER I DA.YML ISTEDET
	
	def nice_date datoen
		return datoen.strftime('%d.%m.%Y')
	end

	def mini_date datoen
		return datoen.strftime('%d%m%y')
	end
  
	def route_exists path
		@r = Rails.application.routes.recognize_path(path)
		@r == nil ? true : false
	end
  
	def delimiter number
		number_with_delimiter(number.to_d, :locale => :da)
	end
  
	def nice_timestamp(timestamp)
		h timestamp.strftime("%d.%m.%y - %H:%M")
	end

	def nice_time(tiden)
		return tiden.strftime(' - %H:%M')
	end
	
	def flowtype_1
		return("<script>$('body').flowtype({  
		minimum:450, 
		maximum:850, 
		minFont:12, 
		maxFont:28, 
		fontRatio:40 
		});</script>")
	end
  
end
