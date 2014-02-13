class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      @partner = Partner.find_by_user_id(user.id)
      if @partner != nil
        session[:partner_id] = @partner.id
        redirect_to :controller => 'hours', :action => 'timeliste'
      else
        redirect_to :controller => session[:current_controller] || 'hours'
      end
        session[:current_controller] = nil
        flash[:notice] = "Du er nu logget ind!"
       #:notice => "Logged in!"
    else
      flash[:notice] = "Forkert password eller email"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:partner_id] = nil
    redirect_to root_url, :notice => "Du er nu logget ud!"
  end

end