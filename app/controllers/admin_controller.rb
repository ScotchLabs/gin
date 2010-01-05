class AdminController < ApplicationController
  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if !user.nil?
        session[:user_id] = user.id
        session[:user_name] = user.name
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || { :action => "welcome" })
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end

  def index
    @shows = Show.all(:order => "performancetimes DESC")
    @updates = Update.all(:order => "updated_at DESC")
    @panes = Pane.all(:order => "panes.order ASC")
    @contents = Content.all
    @users = User.all
  end
  
  def publicview
    session[:display_mode] = "public"
    redirect_to root_url
  end
  
  def fullview
    session[:display_mode] = "full"
    redirect_to root_url
  end
end
