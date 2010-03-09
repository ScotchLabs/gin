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
    # Redirect to closest upcoming show, else redirect to tickets/noshows
    # noshows should have a link to the lightbox
  end

  def noshow
    #@shows = all shows upcoming and not open
  end

  def show
    # find a show with params[:abbrev], else redirect to tickets/showerror
    @show = Show.find_by_abbrev(params[:abbrev])
    if @show.nil?
      redirect_to "/tickets/showerror"
    elsif @show.ticketstatus != "open" || @show.ticketsections.blank?
      redirect_to "/tickets/showclosed"
    end
  end

  def createticketrez
    # create a reservation based on postdata and redirect to tickets/reznewsucess, else flash[:notice] and redirect back to tickets/params[:abbrev]
  end

  def createticketalert
    # create an alert based on postadata and redirect to tickets/alertnewsuccess, else flash[:notice] and redirect back to tickets/params[:abbrev]
  end

  def editticketrez
    # find a reservation with params[:hash], else redirect to tickets/rezerror
    # change reservation based on postdata and redirect to tickets/rezeditsuccess, else flash[:notice] and redirect back to tickets/reservation/params[:hash]
  end

  def removeticketalert
    # find an alert with params[:hash], else redirect to tickets/alertdelerror
    # delete alert, redirect to tickets/alertdelsuccess
  end
protected
  def authorize
  end
end
