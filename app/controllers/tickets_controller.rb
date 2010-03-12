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
    @ticketsections = Ticketsection.all(:conditions => ["showid = ?",@show.abbrev])
    @ticketrez = Ticketrez.new
  end
  
  def create
    if request.post?
      @ticketrez = Ticketrez.new
      @ticketrez.showid = params[:ticketrez][0]
      @ticketrez.name = params[:ticketrez][1]
      @ticketrez.email = params[:ticketrez][2]
      @ticketrez.phone = params[:ticketrez][3]
      @ticketrez.hasid = params[:ticketrez][4]
      if @ticketrez.save
        puts "DEBUG tickets_controller#create: ticketrez saved"
      else
        puts "DEBUG tickets_controller#create: ticketrez did not save"
      end
      @rezlineitems = Array.new
      for r in params[:rezlineitems]
        r = r.split("|")
        rezlineitem = Rezlineitem.new
        rezlineitem.rezid = @ticketrez.id
        rezlineitem.performance = r[0]
        rezlineitem.sectionid = r[1]
        rezlineitem.quantity = r[2]
        if rezlineitem.save
          puts "DEBUG tickets_controller#create: rezlineitem saved"
          @rezlineitems.push(rezlineitem)
        else
          puts "DEBUG tickets_controller#create: rezlineitem did not save"
        end
      end
    end
  end
protected
  def authorize
  end
end
