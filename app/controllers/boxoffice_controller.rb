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
end
