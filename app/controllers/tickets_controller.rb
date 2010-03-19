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
      puts "=============================================================================================================================================="
      puts "DEBUG tickets_controller#create: begin post"
      ###############
      ## TICKETREZ ##
      ###############
      puts "processing ticketrez"
      @ticketrez = Ticketrez.new
      @makerez=true
      @sendemail=true
      @ajax=false
      if !params[:ticketrez][0].nil?
        puts "ajax true"
        ##########
        ## AJAX ##
        ##########
        @ajax=true
        @ticketrez.showid = params[:ticketrez][0]
        @ticketrez.name = params[:ticketrez][1]
        @ticketrez.email = params[:ticketrez][2]
        @ticketrez.phone = params[:ticketrez][3]
        @ticketrez.hasid = params[:ticketrez][4]
        puts "ticketrez info: showid:'#{@ticketrez.showid}', name:'#{@ticketrez.name}', email:'#{@ticketrez.email}', phone:'#{@ticketrez.phone}', hasid:'#{@ticketrez.hasid}'"
        if @ticketrez.save
          puts "ticketrez saved"
          @message = "Your tickets have been reserved. Taking you back to the homepage now...<script type='text/javascript'>function go(){window.location='/'}setTimeout('go()',5000);</script>"
        else
          puts "ticketrez not saved"
          @makerez=false
          @sendemail=false
          @message = "Your ticket reservation information was invalid:"
        end
      else
        #############
        ## NONAJAX ##
        #############
        puts "ajax false"
        @ticketrez = Ticketrez.new(params[:ticketrez])
        puts "ticketrez info: showid:'#{@ticketrez.showid}', name:'#{@ticketrez.name}', email:'#{@ticketrez.email}', phone:'#{@ticketrez.phone}', hasid:'#{@ticketrez.hasid}'"
        if @ticketrez.save
          puts "ticketrez saved"
          @message = "Your tickets have been reserved."
        else
          puts "ticketrez not saved"
          @makerez=false
          @sendemail=false
          @message = "Your ticket reservation information was invalid:"
        end
      end # non-ajax ticketrez
      if @makerez
        puts "processing rezlineitems"
        ##################
        ## REZLINEITEMS ##
        ##################
        @rezlineitems = Array.new
        qty=0
        if !params[:rezlineitems].nil?
          puts "ajax true"
          @ajax=true
          ##########
          ## AJAX ##
          ##########
          for rli in params[:rezlineitems]
            rli = rli.split("|")
            @r = Rezlineitem.new
            @r.rezid = @ticketrez.id
            @r.performance = rli[0]
            @r.sectionid = rli[1]
            @r.quantity = rli[2]
            qty+=@r.quantity
            puts "rezlineitem info: rezid:'#{@r.rezid}', performance:'#{@r.performance}', sectionid:'#{@r.sectionid}', quantity:'#{@r.quantity}'"
            if @r.save
              puts "rezlineitem saved"
              @rezlineitems.push(@r)
            else
              puts "rezlineitem not saved"
              sendemail=false
              @ticketrez.destroy
              @rezlineitems.each {|rez| rez.destroy}
            end
          end
        else
          #############
          ## NONAJAX ##
          #############
          puts "ajax false"
          @ajax=false
          i=0
          while i<params[:form][:section].length
            unless params[:form][:quantity][i].blank?
              @r = Rezlinitem.new
              @r.sectionid = params[:form][:section][i]
              @r.quantity = params[:form][:quantity][i]
              qty+=@r.quantity
              @r.performance = params[:form][:performance][i]
              @r.showid = params[:ticketrez][:showid]
              puts "rezlineitem info: rezid:'#{@r.rezid}', performance:'#{@r.performance}', sectionid:'#{@r.sectionid}', quantity:'#{@r.quantity}'"
              if @r.save
                puts "rezlineitem saved"
                @rezlineitems.push(@r)
              else
                puts "rezlineitem not saved"
                sendemail=false
                @ticketrez.destroy
                @rezlineitems.each {|rez| rez.destroy}
              end
            end
            i=i+1
          end
        end #non-ajax makerez
      end # makerez
      if @sendemail
        puts "sending email"
        unless @ticketrez.email.nil? or @ticketrez.email.blank?
          #TODO actually send an email
        end
      end
    end # request.post?
    puts "DEBUG tickets_controller#create: end post"
    puts "=============================================================================================================================================="
  end
  
  def edit
    @ticketrez=Ticketrez.find_by_hashid(params[:hashid])
    @show = Show.find_by_abbrev(@ticketrez.showid) unless @ticketrez.nil?
    @ticketsections = @ticketsections = Ticketsection.all(:conditions => ["showid = ?",@show.abbrev])
    if @show.nil?
      redirect_to "/tickets/showerror"
    elsif @show.ticketstatus != "open" || @show.ticketsections.blank?
      redirect_to "/tickets/showclosed"
    end
    if request.post?
      puts "=============================================================================================================================================="
      puts "DEBUG tickets_controller#edit: begin post"
      #ajax
      #non-ajax
      #message
      puts "DEBUG tickets_controller#edit: end post"
      puts "=============================================================================================================================================="
    end
  end
protected
  def authorize
  end
end
