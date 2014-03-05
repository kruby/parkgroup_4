class UsersController < ApplicationController
  
	#before_filter :logged_in_as_user?
	before_filter :current_controller #Findes i application_controller.rb
	before_filter :logged_in_as_admin?, :except => ['no_access_admin']

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to :action => 'index'
			flash[:notice] = "Brugeren " + @user.name + " blev oprettet!"
		else
			render "new"
		end
	end
	# 
	# def active
	#  active_controller = params[:controller].classify.constantize
	#  @active_controller = active_controller.find(params[:id])
	#  if @active_controller.active
	#    @active_controller.active = nil
	#    #flash[:notice] = 'Jobbet blev til nul'
	#  else
	#    @active_controller.active = 1
	#  #flash[:notice] = 'Jobbet blev til 1'
	#  end
	# 
	#  @active_controller.update_attributes(params[:active_controller])
	# 
	#  redirect_to(:action => 'index')
	# end

	def no_access_admin
		#Der er her blot for at kunne lede hen til det rigtige layout
	end

	def index
		@users = User.find(:all)
	end

	def show
		@user = User.find(params[:id])
	end

	def destroy
		@user = User.find(params[:id])
		if @user.category == 'Admin'
			if User.admin.count < 2
				flash[:notice] = 'Kan ikke slettes. Altid mindst én admin tilgængelig'
				redirect_to(:action => 'index')
			else
				@user.destroy
				flash[:notice] = 'Brugeren ' + @user.name + ' blev slettet!'
				redirect_to(users_url)
			end
		else
			@user.destroy
			flash[:notice] = 'Brugeren ' + @user.name + ' blev slettet!'
			redirect_to(users_url) 
		end

	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		if @user.category == 'Admin' and params[:user][:category] != 'Admin'
    
			if User.admin.count < 2
				flash[:notice] = 'Kan ikke ændres. Altid mindst én admin tilgængelig'
				redirect_to(:action => 'index')
			else
				update_now
			end
    
		else
			update_now 
		end
	end


	def update_now
		respond_to do |format|
			if @user.update(user_params)
				flash[:notice] = 'Brugeren blev opdateret!'
				#format.html { redirect_to(user_path(@user)) }
				format.html { redirect_to(:action => 'index') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
			end
		end
	end
  
	def active
		active_or_not(params[:id],'user', 'active')
		redirect_to action: 'index'
	end
  
	# before_action :set_user, only: [:show, :edit, :update, :destroy]
	# 
	# # GET /users
	# # GET /users.json
	# def index
	#   @users = User.all
	# end
	# 
	# # GET /users/1
	# # GET /users/1.json
	# def show
	# end
	# 
	# # GET /users/new
	# def new
	#   @user = User.new
	# end
	# 
	# # GET /users/1/edit
	# def edit
	# end
	# 
	# # POST /users
	# # POST /users.json
	# def create
	#   @user = User.new(user_params)
	# 
	#   respond_to do |format|
	#     if @user.save
	#       format.html { redirect_to @user, notice: 'User was successfully created.' }
	#       format.json { render action: 'show', status: :created, location: @user }
	#     else
	#       format.html { render action: 'new' }
	#       format.json { render json: @user.errors, status: :unprocessable_entity }
	#     end
	#   end
	# end
	# 
	# # PATCH/PUT /users/1
	# # PATCH/PUT /users/1.json
	# def update
	#   respond_to do |format|
	#     if @user.update(user_params)
	#       format.html { redirect_to @user, notice: 'User was successfully updated.' }
	#       format.json { head :no_content }
	#     else
	#       format.html { render action: 'edit' }
	#       format.json { render json: @user.errors, status: :unprocessable_entity }
	#     end
	#   end
	# end
	# 
	# # DELETE /users/1
	# # DELETE /users/1.json
	# def destroy
	#   @user.destroy
	#   respond_to do |format|
	#     format.html { redirect_to users_url }
	#     format.json { head :no_content }
	#   end
	# end
	# 
	private
	# Use callbacks to share common setup or constraints between actions.
	def set_user
		@user = User.find(params[:id])
	end
  
	# Never trust parameters from the scary internet, only allow the white list through.
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, :blogname, :name, :category, :active, :partner_id, :avatar)
	end
    
    
    
    
      
        
    
    
    
end
