class PartnersController < ApplicationController
	before_action :set_partner, only: [:show, :edit, :update, :destroy]
  
	before_filter :current_controller #Findes i application_controller.rb
	before_filter :logged_in_as_admin? #Findes i application_controller.rb

	# GET /partners
	# GET /partners.json
	# def index
	# 	@partners = Partner.all.order(name: :asc)
	# end
	
	def index
	  @q = Partner.search(params[:q])
	  @partners = @q.result.order(name: :asc)
	end
	

	# GET /partners/1
	# GET /partners/1.json
	def show
	end

	# GET /partners/new
	def new
		@partner = Partner.new
	end

	# GET /partners/1/edit
	def edit
	end

	# POST /partners
	# POST /partners.json
	def create
		@partner = Partner.new(partner_params)

		respond_to do |format|
			if @partner.save
				format.html { redirect_to @partner, notice: 'Partner was successfully created.' }
				format.json { render action: 'show', status: :created, location: @partner }
			else
				format.html { render action: 'new' }
				format.json { render json: @partner.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /partners/1
	# PATCH/PUT /partners/1.json
	def update
		respond_to do |format|
			if @partner.update(partner_params)
				format.html { redirect_to @partner, notice: 'Partner was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @partner.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /partners/1
	# DELETE /partners/1.json
	def destroy
		@partner.destroy
		respond_to do |format|
			format.html { redirect_to partners_url }
			format.json { head :no_content }
		end
	end
	
	def all_partner_hours
		#@partners = Partner.all
		@partners = Partner.all.joins(:hours).uniq.order(name: :asc)
	end 

	def show_years
		#@partners_with_hours = Partner.joins(:hours).uniq.order(company: :asc)
		# Finder en af hver partner der har timer koblet på
		@partner = Partner.find(params[:partner_id])
		@partners = [] << @partner
		# Finder den aktuelle partner
		find_years(@partner)
		# Finder den aktuelle partners timer og kun den første fra hvert år
		render(:action => 'all_partner_hours')
	end

	def find_years(partner)
		@year = partner.hours.order(date: :asc).first.date.year
		@this_year = Time.now.year
		@years = []
		until @year == @this_year
			@years << @year
			@year += 1
		end
		return @years
	end

	def show_months
		#@partners_with_hours = Partner.joins(:hours).uniq.order(company: :asc)
		@partner = Partner.find(params[:partner_id])
		@partners = [] << @partner
		find_years(@partner)
		find_months(@partner, params[:year])
		render(:action => 'all_partner_hours')
	end

	def find_months(partner, year)
		@hours = Hour.customer(partner.id).year_hours(year.to_i).order(date: :asc)
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
		@partner = Partner.find(params[:partner_id])
		@partners = [] << @partner
		find_years(@partner)
		find_months(@partner, params[:year])
		@hours = Hour.customer(@partner.id).month_hours(Date.new(params[:year].to_i,params[:month].to_i)).order(date: :asc) 
		render(:action => 'all_partner_hours')
	end



	private
	# Use callbacks to share common setup or constraints between actions.
	def set_partner
		@partner = Partner.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def partner_params
		params.require(:partner).permit(:name, :address, :postno, :city, :log, :category, :responsible, :info, :next_action, :lock_version, :user_id, :search_lock, :phone, :email, :homepage)
	end
end
