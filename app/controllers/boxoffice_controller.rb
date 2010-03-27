class BoxofficeController < AdminController
  layout 'admin', :except => "login"
  def index
    shows = Show.all
    shows.sort! { |x, y| Time.parse(x.performancetimes.split("|")[0])<=>Time.parse(y.performancetimes.split("|")[0]) }
    shows.reverse.each { |s| @show = s unless !s.upcoming }
    redirect_to :controller => "boxoffice", :action => "show", :abbrev => @show.abbrev unless @show.nil?
  end

  def show
    shows = Show.all
    shows.sort! { |x, y| Time.parse(x.performancetimes.split("|")[0])<=>Time.parse(y.performancetimes.split("|")[0]) }
    shows.reverse.each { |s| @show = s unless !s.upcoming }
    @perfs = @show.performancetimes.split("|")
    @sections = Ticketsection.all(:conditions => ["showid = ?",@show.abbrev])
  end
protected
  def authorize
    user = User.find_by_id(session[:user_id])
    if user.nil?
      session[:original_uri] = request.request_uri
      redirect_to :controller => "boxoffice", :action => "login"
    end
    if controller_name != "admin" and !user.nil?
      puts "DEBUG application_controller: checking if user '#{session[:user_name]}' has access to controller '#{controller_name}', action '#{action_name}'"
      okcontinue = user.hasaccess(controller_name, action_name)
      puts "DEBUG application_controller: okcontinue is '#{okcontinue.to_s}'"
      unless okcontinue
        flash[:notice] = "You don't have access to that."
        puts "DEBUG application_controller: user #{session[:user_name]} doesn't have access to controller #{controller_name}. Redirecting to admin"
        redirect_to :controller => "admin"
      end
    end
  end
end
