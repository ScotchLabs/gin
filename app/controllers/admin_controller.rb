class AdminController < ApplicationController
  def login
    puts "DEBUG admin_controller: user logging in..."
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if !user.nil?
        session[:user_id] = user.id
        session[:user_name] = user.name
        puts "DEBUG admin_controller: user '#{session[:user_name]}' exists"
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || { :action => "index" })
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    session[:display_mode] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
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
