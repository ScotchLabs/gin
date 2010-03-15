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
      sendemail=true
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
          sendemail=false
          @message = "Your ticket reservation information was invalid. Please make sure you have the name, email, phone, and ID fields properly filled."
        end
      else
        # for the non-ajax call
        @ticketrez = Ticketrez.new(params[:ticketrez])
        if @ticketrez.save
          @message = "Your tickets have been reserved."
        else
          makerez=false
          sendemail=false
          @message = "Your ticket reservation information was invalid:"
          if @ticketrez.name.nil? or @ticketrez.name.blank?
            @message += "<br />Name field is required."
          end
          if @ticketrez.phone.nil? or @ticketrez.phone.blank?
            @message += "<br />Phone field is required."
          elsif (@ticketrez.phone=~/^(?:(1)?\s*[-\/\.]?)?(?:\((\d{3})\)|(\d{3}))\s*[-\/\.]?\s*(\d{3})\s*[-\/\.]?\s*(\d{4})\s*(?:(?:[xX]|[eE][xX][tT])\.?\s*(\d+))*$/).nil?
            @message += "<br />Phone number '#{@ticketrez.phone}' is invalid."
          end
          if !@ticketrez.email.nil? and !@ticketrez.email.blank? and (@ticketrez.email=~/[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/).nil?
            @message += "<br />Email address '#{@ticketrez.email}' is invalid."
          end
          if @ticketrez.hasid.nil? or @ticketrez.hasid.blank?
            @message += "<br />ID field is required."
          end
          ta=Ticketrez.all(:conditions => ["showid = ?", showid])
          for other in ta
            if other.unformattedphone == @ticketrez.unformattedphone
              @message += "<br />There is already a reservation for this phone number. If you wish to change or cancel your reservation go to the url you were given at the time you reserved your tickets. Contact the <a href='mailto:webmaster@snstheatre.org'>system administrator</a> if you're having trouble."
            end
          end
          @message += "<br /><a href='/tickets/show/#{params[:ticketrez][:showid]}'>Back</a>"
        end
      end # non-ajax ticketrez
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
              sendemail=false
              puts "DEBUG tickets_controller#create: rezlineitem did not save"
              @message = "One or more of your ticket quantities was invalid."
              @ticketrez.destroy
              @rezlineitems.each {|r| r.destroy}
            end
          end
        else
          # for the non-ajax call
          qty=0
          i=0
          while i<params[:form][:section].length
            unless params[:form][:quantity][i].blank?
              r = Rezlinitem.new
              r.sectionid = params[:form][:section][i]
              r.quantity = params[:form][:quantity][i]
              qty+=r.quantity
              r.performance = params[:form][:performance][i]
              r.showid = params[:ticketrez][:showid]
              if r.save
                @rezlineitems.push(r)
              else
                sendemail=false
                @message += "<br />Your ticket quantities were invalid:"
                @ticketrez.destroy
                @rezlineitems.each {|rez| rez.destroy}
                unless r.quantity.nil? or r.quantity.blank?
                  #TODO quantity is 0
                  #TODO quantity is NaN
                  section=Ticketsection.find(r.sectionid)
                  unless section.nil? or r.performance.nil? of r.performance.blank?
                    if r.quantity>section.numavailable(r.performance)
                      @message += "<br />Quantity was over number of tickets available for that section and performance."
                    end
                  end
                end
                if Ticketsection.find(r.sectionid).nil?
                  @message += "<br />Section ID is invalid. Please contact the <a href='mailto:webmaster@snstheatre.org'>system administrator</a>."
                end
                s=Show.find_by_abbrev(r.showid)
                if s.nil?
                  @message += "<br />Show ID is invalid. Please contact the <a href='mailto:webmaster@snstheatre.org'>system administrator</a>."
                else
                  perfs=s.performancetimes.split("|")
                  foundperf=false
                  for perf in perfs
                    foundperf=true if DateTime.parse(perf)==DateTime.parse(r.performance)
                  end
                  unless foundperf
                    @message += "<br />Performance selection was invalid. Please contact the <a href='mailto:webmaster@snstheatre.org'>system administrator</a>."
                  end
                end
              end
            end
            i=i+1
          end
          if qty==0
            @message += "<br />Ticket quantities are required."
          end
          @message += "<br /><a href='/tickets/show/#{params[:ticketrez][:showid]}'>Back</a>"
        end #non-ajax makerez
      end # makerez
      if sendemail
        @message += "<br />The ID for your reservation is #{@ticketrez.hashid}<br />In order to edit or cancel your reservation, visit this link: <a href='http://snstheatre.org/tickets/edit/#{@ticketrez.hashid}'>http://snstheatre.org/tickets/edit/#{@ticketrez.hashid}</a>"
        unless @ticketrez.email.nil? or @ticketrez.email.blank?
          #TODO actually send an email
          @message += "<br />An email receipt has been sent to #{@ticketrez.email}"
        else
          @message += "<br />You didn't input an email address, so keep track of this ID in case you ever want to change your reservation."
        end
      end
    end # request.post?
  end
  
  def edit
    #TODO
  end
protected
  def authorize
  end
end
