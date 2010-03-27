# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :authorize, :except => [:login, :createaccount, :forgot, :forgoterror, :forgotnone]
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
protected
  #TODO enable user account views in admin
  # override this in specific controllers to get past authorization
  def authorize
    puts "DEBUG application_controller: authorizing"
    user = User.find_by_id(session[:user_id])
    if user.nil?
      puts "DEBUG application_controller: redirecting"
      session[:original_uri] = request.request_uri
      flash[:notice] = "please log in"
      if controller_name == "boxoffice"
        redirect_to :controller => "boxoffice", :action => "login"
      else
        redirect_to :controller => "admin", :action => "login"
      end
    else
      if controller_name != "admin"
        puts "DEBUG application_controller: checking if user '#{session[:user_name]}' has access to controller '#{controller_name}', action '#{action_name}'"
        okcontinue = hasaccess?(session[:user_id],controller_name, action_name)
        puts "DEBUG application_controller: okcontinue is '#{okcontinue.to_s}'"
        unless okcontinue
          flash[:notice] = "You don't have access to that."
          puts "DEBUG application_controller: user #{session[:user_name]} doesn't have access to controller #{controller_name}. Redirecting to admin"
          redirect_to :controller => "admin"
        end
      end
    end
  end
private

  def hasaccess?(u,controller,action)
    user = User.find(u)
    if action == "index" || action == "show"
      crud = "r"
    elsif action == "edit" || action == "update"
      crud = "u"
    elsif action == "new" || action == "create"
      crud = "c"
    elsif action == "destroy"
      crud = "d"
    end
    puts "DEBUG application_controller#hasaccess: user '#{user}' controller '#{controller}', crud '#{crud}'"
    if (user.nil? or controller.nil? or controller.blank? or crud.nil?)
      puts "DEBUG application_controller#hasaccess: returning false"
      return false
    end
    if !session[:user_permissions].nil? and !session[:user_permissions]["#{controller}"].nil? and !session[:user_permissions]["#{controller}"]["#{crud}"].nil?
      access = session[:user_permissions]["#{controller}"]["#{crud}"]
      puts "DEBUG application_controller#hasaccess: already loaded in session, returning #{access}"
      return access
    end
    puts "DEBUG application_controller#hasaccess: not loaded in session, checking roles"
    access = false
    roleassocs = Roleassoc.all(:conditions => ["userid = ?",user.name])
    for roleassoc in roleassocs
      role = Role.find_by_rabbrev(roleassoc.roleid)
      #somehow get the controller crud out of role
      puts "DEBUG application_controller#hasaccess: role '#{role}', controller '#{controller}', crud '#{crud}'"
      access = access || (!role.send("r"+controller).nil? && role.send("r"+controller).include?(crud))
      puts "DEBUG application_controller#hasaccess: access after role #{access}"
      break if access
    end
    session[:user_permissions] = Hash.new if session[:user_permissions].nil?
    session[:user_permissions]["#{controller}"] = Hash.new if session[:user_permissions]["#{controller}"].nil?
    puts "DEBUG application_controller#hasaccess: putting #{access} in session[:user_permissions][#{controller}][#{crud}]"
    session[:user_permissions]["#{controller}"]["#{crud}"] = access
    puts "DEBUG application_controller#hasaccess: session[:user_permissions][#{controller}][#{crud}] now holds "+session[:user_permissions]["#{controller}"]["#{crud}"].to_s
    access
  end

end
