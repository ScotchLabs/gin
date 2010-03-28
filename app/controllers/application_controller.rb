# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :authorize, :except => [:login, :logout, :createaccount, :forgot, :forgoterror, :forgotnone]
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation, :retype
protected
  # override this in specific controllers to get past authorization
  def authorize
    puts "DEBUG application_controller: authorizing"
    user = User.find_by_id(session[:user_id])
    if user.nil?
      # user hasn't logged in yet, redirect them to login page
      puts "DEBUG application_controller: redirecting"
      session[:original_uri] = request.request_uri
      flash[:notice] = "please log in"
      if controller_name == "boxoffice"
        redirect_to :controller => "boxoffice", :action => "login"
      else
        redirect_to :controller => "admin", :action => "login"
      end
    else
      # user has logged in, but is doing something admin-y.
      # check if user has access to wherever it is they're trying to go.
      # also log user, controlle,r action, and time
      if controller_name != "admin"
        puts "DEBUG application_controller: checking if user '#{session[:user_name]}' has access to controller '#{controller_name}', action '#{action_name}'"
        okcontinue = hasaccess?(session[:user_id],controller_name, action_name)
        puts "DEBUG application_controller: okcontinue is '#{okcontinue.to_s}'"
        if okcontinue
          if action_name=="create" or action_name=="update" or action_name=="destroy"
            Logger.new("log/info.log").info {"#{session[:user_name]} rendered #{controller_name}##{action_name}, related id: #{params[:id].to_s}, time: #{Time.now}"}
          end
        else
          flash[:notice] = "You don't have access to that."
          puts "DEBUG application_controller: user #{session[:user_name]} doesn't have access to controller #{controller_name}. Redirecting to admin"
          redirect_to :controller => "admin"
        end
      end
    end
  end
  
private

  def hasaccess?(u,controller,action)
    if action == "index" || action == "show"
      crud = "r"
    elsif action == "edit" || action == "update"
      crud = "u"
    elsif action == "new" || action == "create"
      crud = "c"
    elsif action == "destroy"
      crud = "d"
    end
    if !session[:user_permissions].nil? and !session[:user_permissions]["#{controller}"].nil? and !crud.nil? and !session[:user_permissions]["#{controller}"]["#{crud}"].nil?
      access = session[:user_permissions]["#{controller}"]["#{crud}"]
      puts "DEBUG application_controller#hasaccess: already loaded in session, returning #{access}"
      return access
    end
    puts "DEBUG application_controller#hasaccess: not loaded in session, checking roles"
    
    user = User.find(u)
    access = user.hasaccess(controller, action)
    
    session[:user_permissions] = Hash.new if session[:user_permissions].nil?
    session[:user_permissions]["#{controller}"] = Hash.new if session[:user_permissions]["#{controller}"].nil?
    puts "DEBUG application_controller#hasaccess: putting #{access} in session[:user_permissions][#{controller}][#{crud}]"
    session[:user_permissions]["#{controller}"]["#{crud}"] = access
    puts "DEBUG application_controller#hasaccess: session[:user_permissions][#{controller}][#{crud}] now holds "+session[:user_permissions]["#{controller}"]["#{crud}"].to_s
    access
  end

end
