class AdminController < ApplicationController

  def login
    puts "DEBUG admin_controller: user '#{params[:name]}' logging in..."
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
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end
end
