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
    @ticketrez = Ticketrez.new
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
      makerez=true
      if !params[:ticketrez][0].nil?
        # for the ajax call
        @ticketrez.showid = params[:ticketrez][0]
        @ticketrez.name = params[:ticketrez][1]
        @ticketrez.email = params[:ticketrez][2]
        @ticketrez.phone = params[:ticketrez][3]
        @ticketrez.hasid = params[:ticketrez][4]
        if @ticketrez.save
          @message = "Your tickets have been reserved. Taking you back to the homepage now...<script type='text/javascript'>function go(){window.location='/'}setTimeout('go()',5000);</script>"
        else
          makerez=false
          @message = "Your ticket reservation information was invalid. Please make sure you have the name, email, phone, and ID fields properly filled."
        end
      else
        # for the non-ajax call
        @ticketrez = Ticketrez.new(params[:ticketrez])
        if @ticketrez.save
          @message = "Your tickets have been reserved."
        else
          makerez=false
          #TODO make better validation
          @message = "Your ticket reservation information was invalid. Please make sure you have the name, email, phone, and ID fields properly filled."
        end
      end
      if makerez
        @rezlineitems = Array.new
        if !params[:rezlineitems].nil?
          # for the ajax call
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
              @message = "One or more of your ticket quantities was invalid."
              @ticketrez.destroy
              @rezlineitems.each {|r| r.destroy}
            end
          end
        else
          # for the non-ajax call
          i=0
          while i<params[:form][:section].length
            unless params[:form][:quantity][i].blank?
              r = Rezlinitem.new
              r.sectionid = params[:form][:section][i]
              r.quantity = params[:form][:quantity][i]
              r.performance = params[:form][:performance][i]
              r.showid = params[:ticketrez][:showid]
              if r.save
                @rezlineitems.push(r)
              else
                @message = "Your ticket quantities were invalid. Please check them."
                @ticketrez.destroy
                @rezlineitems.each {|rez| rez.destroy}
              end
            end
            i=i+1
          end
        end
      end
    end
  end
protected
  def authorize
  end
end
