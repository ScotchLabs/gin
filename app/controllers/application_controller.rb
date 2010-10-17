# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation, :retype

  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = exception.message
    if current_user.guest?
      redirect_to root_url
    else
      redirect_to :controller => "admin"
    end
  end
  
  helper_method :current_user
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    else
      User.new
    end
  end
end
