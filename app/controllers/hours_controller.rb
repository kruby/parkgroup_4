class HoursController < ApplicationController
  
	#before_filter :login_required, :admin_required
	before_filter :current_controller #Findes i application_controller.rb
	before_filter :logged_in_as_user? #Findes i application_controller.rb
	before_filter :logged_in_as_admin?, :except => ['timeliste', 'show_months_public', 'hide_months_public', 'show_days_public', 'hide_days_public']
    
	# def search
	# 	session[:relation_id] = nil
	# 	session[:show_years] = nil
	# 	session[:year] = nil
	# 	session[:month] = nil
	# 	if params[:relation_id]
	# 		session[:relation_id] = params[:relation_id]
	# 		session[:show_years] = true
	# 		@relation = Relation.find(params[:relation_id])
	# 		@q = @relation.hours.search(params[:q])
	# 		@hours = @q.result.joins(:relation).reorder('company ASC').all
	# 	else
	# 		@q = Hour.search(params[:q])
	# 		@hours = @q.result.joins(:relation).reorder('company ASC').all
	# 	end
	# 	render :index
	# end
	
	# def search
	# 	@q = Hour.search(params[:q])
	# 	@relation_with_hours = @q.result.joins(:hours).uniq.order(company: :asc)
	# 	render :index
	# end
	
	# GET /hours
	# GET /hours.xml
	def index
		@relations_size = Relation.all.size
		@relations = Relation.all.joins(:hours).uniq.order(company: :asc)
	end

	# def index
	# 	session[:relation_id] = nil
	# 	session[:show_years] = nil
	# 	session[:year] = nil
	# 	session[:month] = nil
	# 	if params[:relation_id]
	# 		session[:relation_id] = params[:relation_id]
	# 		session[:show_years] = true
	# 		@relation = Relation.find(params[:relation_id])
	# 		@q = @relation.hours.search(params[:q])
	# 		@hours = @q.result.joins(:relation).reorder('company ASC').all
	# 	else
	# 		@q = Hour.search(params[:q])
	# 		@hours = @q.result.joins(:relation).reorder('company ASC').all
	# 	end
	# end

  
	def monthly
		# @hours = Hour.reorder('date ASC').all
		@hours = Hour.last_3_years(Time.now).reorder('date ASC')
	end
  
	# def show_years
	# 	if params[:relation_id]
	# 		session[:relation_id] = params[:relation_id]
	# 		session[:show_years] = true
	# 		session[:year] = nil
	# 		session[:month] = nil
	# 		@relation = Relation.find(params[:relation_id])
	# 		@q = @relation.hours.search(params[:q])
	# 	else
	# 		@q = Hour.search(params[:q])
	# 	end
	# 	@hours = @q.result.reorder('relation_id DESC, date DESC').all
	# 	render(:action => 'index')
	# end


	def show_years
		#@relations_with_hours = Relation.joins(:hours).uniq.order(company: :asc)
		# Finder en af hver relation der har timer koblet på
		@relation = Relation.find(params[:relation_id])
		@relations_with_hours = [] << @relation
		# Finder den aktuelle relation
		find_years(@relation)
		# Finder den aktuelle relations timer og kun den første fra hvert år
		render(:action => 'index')
	end

	def find_years(relation)
		@year = relation.hours.order(date: :asc).first.date.year
		@this_year = Time.now.year
		@years = []
		until @year == @this_year
			@years << @year
			@year += 1
		end
		return @years
	end

	# def show_months
	# 	if params[:relation_id]
	# 		#session[:relation_id] = params[:relation_id]
	# 		session[:year] = params[:year]
	# 		session[:month] = nil
	# 		@relation = Relation.find(params[:relation_id])
	# 		@q = @relation.hours.search(params[:q])
	# 	else
	# 		@q = Hour.search(params[:q])
	# 	end
	# 	@hours = @q.result.reorder('relation_id DESC, date DESC').all
	# 	render(:action => 'index')
	# end


	def show_months
		#@relations_with_hours = Relation.joins(:hours).uniq.order(company: :asc)
		@relation = Relation.find(params[:relation_id])
		@relations_with_hours = [] << @relation
		#@relations_with_hours << @relation
		find_years(@relation)
		find_months(@relation, params[:year])
		render(:action => 'index')
	end

	def find_months(relation, year)
		@hours = Hour.customer(relation.id).year_hours(year.to_i).order(date: :asc)
		@month_dates = []
		@month_dates << @hours.first.date
		@month_previous = @hours.first.date.month.to_s
		@hours.each do |hour|
			if hour.date.month.to_s != @month_previous
				@month_dates << hour.date
				@month_previous = hour.date.month.to_s
			end
		end
		return @month_dates
	end

	def show_days
		@relation = Relation.find(params[:relation_id])
		@relations_with_hours = [] << @relation
		find_years(@relation)
		find_months(@relation, params[:year])
		@hours = Hour.customer(@relation.id).month_hours(Date.new(params[:year].to_i,params[:month].to_i)).order(date: :asc) 
		render(:action => 'index')
	end



	# def hide_years
	# 	if params[:relation_id]
	# 		session[:show_years] = nil
	# 		session[:year] = nil
	# 		session[:month] = nil
	# 		@relation = Relation.find(params[:relation_id])
	# 		@q = @relation.hours.search(params[:q])
	# 	else
	# 		@q = Hour.search(params[:q])
	# 	end
	# 	@hours = @q.result.reorder('relation_id DESC, date DESC').all
	# 	render(:action => 'index')
	# end
  
  
	# def hide_months
	# 	#session[:relation_id] = nil
	# 	session[:year] = nil
	# 	if params[:relation_id]
	# 		@relation = Relation.find(params[:relation_id])
	# 		@q = @relation.hours.search(params[:q])
	# 	else
	# 		@q = Hour.search(params[:q])
	# 	end
	# 	@hours = @q.result.reorder('relation_id DESC, date DESC').all
	# 	render(:action => 'index')
	# end
  
	# def show_days
	# 	if params[:month]
	# 		session[:month] = params[:month]
	# 	end
	# 	if params[:relation_id]
	# 		@relation = Relation.find(params[:relation_id])
	# 		@q = @relation.hours.search(params[:q])    
	# 	else
	# 		@q = Hour.search(params[:q])
	# 	end  
	# 	@hours = @q.result.reorder('relation_id DESC, date DESC').all
	# 	render(:action => 'index')
	# end
  
	# def hide_days
	# 	session[:month] = nil
	# 	if params[:relation_id]
	# 		@relation = Relation.find(params[:relation_id])
	# 		@q = @relation.hours.search(params[:q])    
	# 	else
	# 		@q = Hour.search(params[:q])
	# 	end  
	# 	@hours = @q.result.reorder('relation_id DESC, date DESC').all
	# 	render(:action => 'index')
	# end
	#   
	def show_months_public
		session[:month] = nil
		if params[:relation_id]
			session[:year] = params[:year]
		end
		@relation = Relation.find(session[:relation_id])
		@q = @relation.hours.search(params[:q])
		@hours = @q.result.reorder('date DESC').all
		render(:action => 'timeliste')
	end
  
	def hide_months_public
		session[:year] = nil
		session[:month] = nil
		@relation = Relation.find(session[:relation_id])
		@q = @relation.hours.search(params[:q])
		@hours = @q.result.reorder('date DESC').all
		render(:action => 'timeliste')
	end
  
	def show_days_public
		if params[:month]
			session[:month] = params[:month]
		end
		@relation = Relation.find(session[:relation_id])
		@q = @relation.hours.search(params[:q])
		@hours = @q.result.reorder('date DESC').all
		render(:action => 'timeliste')
	end
  
	def hide_days_public
		session[:month] = nil
		@relation = Relation.find(session[:relation_id])
		@q = @relation.hours.search(params[:q])
		@hours = @q.result.reorder('date DESC').all
		render(:action => 'timeliste')
	end
  
	def timeliste
		@relation = Relation.find(session[:relation_id])
		@q = @relation.hours.search(params[:q])
		@hours = @q.result.reorder('relation_id DESC, date DESC').all 
		#@hours = Hour.timeliste(current_user.relation_id).order('date desc')
	end

	# GET /hours/1
	# GET /hours/1.xml
	def show
		@hour = Hour.find(params[:id])

		redirect_to(:action => 'index')
		# respond_to do |format|
		#       format.html # show.html.erb
		#       format.xml  { render :xml => @hour }
		#     end
	end

	# GET /hours/new
	# GET /hours/new.xml
	def new
		@hour = Hour.new

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @hour }
		end
	end

	# GET /hours/1/edit
	def edit
		#@hour = Hour.find(params[:id])
		session[:hour_id] = params[:id]
		if params[:relation_id]
			@relation = Relation.find(params[:relation_id])
			@q = @relation.hours.search(params[:q])    
		else
			@q = Hour.search(params[:q])
		end  
		@hours = @q.result.order('relation_id DESC, date DESC').all
		render :action => 'index'
	end
  

	# # GET /hours/1/edit
	# def edit
	#   #@hour = Hour.find(params[:id])
	#   session[:hour_id] = params[:id]
	#   @q = Hour.search(params[:q])
	#   @hours = @q.result.order('relation_id DESC, date DESC').all
	#   render :action => 'index'
	# end

	# POST /hours
	# POST /hours.xml
	def create
		@hour = Hour.new(params[:hour])

		respond_to do |format|
			if @hour.save
				flash[:notice] = 'Timeregistreringen blev oprettet!'
				session[:hour_id] = params[:id]
				format.html { redirect_to(:action => 'index') }
				format.xml  { render :xml => @hour, :status => :created, :location => @hour }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @hour.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /hours/1
	# PUT /hours/1.xml
	def update
		@hour = Hour.find(params[:id])

		respond_to do |format|
			if @hour.update_attributes(params[:hour])
				flash[:notice] = 'Timeregistreringen blev opdateret.'
				session[:hour_id] = nil
				format.html { redirect_to(:action => 'index', :relation_id => params[:hour][:relation_id]) }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @hour.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /hours/1
	# DELETE /hours/1.xml
	def destroy
		@hour = Hour.find(params[:id])
		@hour.destroy

		respond_to do |format|
			format.html { redirect_to(:action => 'index', :relation_id => session[:relation_id]) }
			format.xml  { head :ok }
		end
	end
end
