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
    if session[:user_id].nil? or User.find_by_id(session[:user_id]).nil?
      puts "DEBUG application_controller: redirecting"
      session[:original_uri] = request.request_uri
      flash[:notice] = "please log in"
      redirect_to :controller => "admin", :action => "login"
    elsif controller_name != "admin"
      puts "DEBUG application_controller: checking if user '#{session[:user_name]}' has access to controller '#{controller_name}', action '#{action_name}'"
      okcontinue = User.find_by_id(session[:user_id]).hasaccess(controller_name, action_name)
      puts "DEBUG application_controller: okcontinue is '#{okcontinue.to_s}'"
      unless okcontinue
        flash[:notice] = "You don't have access to that."
        puts "DEBUG application_controller: user #{session[:user_name]} doesn't have access to controller #{controller_name}. Redirecting to admin"
        redirect_to :controller => "admin"
      end
    end
  end
end
