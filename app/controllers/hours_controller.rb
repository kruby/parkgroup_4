class HoursController < ApplicationController
	before_action :set_hour, only: [:show, :edit, :update, :destroy]

	# GET /hours
	# GET /hours.json
	# def index
	# 	@hours = Hour.all.order(date: :desc)
	# end


	def index
	  @q = Hour.search(params[:q])
	  @hours = @q.result.order(date: :desc)
	end
	
	# GET /hours/1
	# GET /hours/1.json
	def show
	end

	# GET /hours/new
	def new
		@hour = Hour.new
	end

	# GET /hours/1/edit
	def edit
	end

	# POST /hours
	# POST /hours.json
	def create
		@hour = Hour.new(hour_params)

		respond_to do |format|
			if @hour.save
				format.html { redirect_to @hour, notice: 'Hour was successfully created.' }
				format.json { render action: 'show', status: :created, location: @hour }
			else
				format.html { render action: 'new' }
				format.json { render json: @hour.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /hours/1
	# PATCH/PUT /hours/1.json
	def update
		respond_to do |format|
			if @hour.update(hour_params)
				format.html { redirect_to show_days_path(partner_id: @hour.partner_id, year: @hour.date.year, month: @hour.date.month), notice: 'Opdateringen blev gennemført.'}
				#format.html { redirect_to @hour, notice: 'Hour was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @hour.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /hours/1
	# DELETE /hours/1.json
	def destroy
		@hour.destroy
		respond_to do |format|
			format.html { redirect_to hours_url }
			format.json { head :no_content }
		end
	end

	def monthly
		# @hours = Hour.reorder('date ASC').all
		@hours = Hour.last_3_years(Time.now).reorder('date ASC')
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_hour
		@hour = Hour.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def hour_params
		params.require(:hour).permit(:description, :number, :number, :date, :user_id, :relation_id)
	end
end
