# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :authorize, :except => :login
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
protected
  # override this in specific controllers to get past authorization
  def authorize
    unless User.find_by_id(session[:user_id])
      session[:original_uri] = request.request_uri
      flash[:notice] = "please log in"
      redirect_to :controller => "admin", :action => "login"
    end
    if controller_name != "admin"
      puts "DEBUG application_controller: checking if user '#{session[:user_name]}' has access to controller '#{controller_name}', action '#{action_name}'"
      okcontinue = User.find(session[:user_id]).hasaccess(controller_name, action_name)
      puts "DEBUG application_controller: okcontinue is '#{okcontinue.to_s}'"
      unless okcontinue
        flash[:notice] = "You don't have access to that."
        puts "DEBUG application_controller: user #{session[:user_name]} doesn't have access to controller #{controller_name}. Redirecting to admin"
        redirect_to :controller => "admin"
      end
    end
  end
end
