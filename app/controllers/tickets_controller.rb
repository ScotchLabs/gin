class TicketsController < ApplicationController
  layout 'index'
  def index
    @shows = Show.all
    @shows.sort! { |x, y| Time.parse(x.performancetimes.split("|")[0])<=>Time.parse(y.performancetimes.split("|")[0]) }
    @shows.reverse.each { |show| @activeshow = show if show.upcoming && show.ticketstatus=="open" }
    if @activeshow.nil?
      redirect_to "/tickets/noshows"
    else
      redirect_to "/tickets/show/#{@activeshow.abbrev}"
    end
  end

  def noshow
    @shows = Show.find_by_ticketstatus("closed")
    @shows.sort! { |x, y| Time.parse(x.performancetimes.split("|")[0])<=>Time.parse(y.performancetimes.split("|")[0]) }
  end

  def show
    # find a show with params[:abbrev], else redirect to tickets/showerror
    @show = Show.find_by_abbrev(params[:abbrev])
    if @show.nil?
      redirect_to "/tickets/showerror"
    elsif @show.ticketstatus != "open" || @show.ticketsections.blank?
      redirect_to "/tickets/showclosed"
    end
    
    @ticketrez = Ticketrez.new
  end
  
  def createticketrez
    @ticketrez = Ticketrez.new(params[:ticketrez])
    #process section/performance info
    respond_to do |format|
      if @ticketrez.save
        flash[:notice] = 'Ticketrez was successfully created.'
        render :action => "newrezsuccess"
      else
        render :action => "show", :abbrev => @ticketrez.showid
      end
    end
  end
protected
  def authorize
  end
end
