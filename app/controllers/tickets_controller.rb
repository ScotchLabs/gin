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
    else
      @ticketsections = @show.ticketsections
    end
    
    if @show.ticketstatus != "open" or @ticketsections.empty?
      redirect_to "/tickets/showclosed"
    end
      
    @ticketrez = Ticketrez.new
  end
  
  def create
    if request.post?
      @ticketrezdidntsave = false
      @rezlineitemdidntsave = false
      @emailsent = false
      ###############
      ## TICKETREZ ##
      ###############
      @makerez=true
      @sendemail=true
      @ajax=false
      if !params[:ticketrez][0].nil?
        ##########
        ## AJAX ##
        ##########
        @ticketrez = Ticketrez.new
        @ajax=true
        @ticketrez.showid = params[:ticketrez][0]
        @ticketrez.name = params[:ticketrez][1]
        @ticketrez.email = params[:ticketrez][2]
        @ticketrez.hasid = params[:ticketrez][3]
      else
        #############
        ## NONAJAX ##
        #############
        @ticketrez = Ticketrez.new(params[:ticketrez])
      end # non-ajax ticketrez
      unless @ticketrez.save
        puts "DEBUG tickets_controller#create: couldn't save ticketrez"
        @ticketrezdidntsave = true
        @makerez=false
        @sendemail=false
      end
      
      
      @show = Show.find_by_abbrev(@ticketrez.showid)
      if @makerez
        puts "DEBUG tickets_controller#create: made it to makerez"
        ##################
        ## REZLINEITEMS ##
        ##################
        @rezlineitems = Array.new
        @qty=0
        if !params[:rezlineitems].nil?
          ##########
          ## AJAX ##
          ##########
          @ajax=true
          for rli in params[:rezlineitems]
            rli = rli.split("|")
            @r = Rezlineitem.new
            @r.rezid = @ticketrez.id
            @r.performance = rli[0]
            @r.sectionid = rli[1]
            @r.quantity = rli[2]
            @qty+=@r.quantity
            if @r.save
              @rezlineitems.push(@r)
            else
              @rezlineitemsdidntsave = true
              @sendemail=false
              @ticketrez.destroy
              @rezlineitems.each {|rez| rez.destroy}
              break
            end
          end
        else
          #############
          ## NONAJAX ##
          #############
          puts "DEBUG tickets_controller#create: makerez nonajax"
          @ajax=false
          i=0
          puts "DEBUG tickets_controller#create: while i<params form section length '#{params[:form][:section].length}'"
          while i<params[:form][:section].length
            puts "DEBUG tickets_controller#create: params form quantity #{i.to_s} blank? '#{params[:form][:quantity][i.to_s].blank?}'"
            unless params[:form][:quantity][i.to_s].blank?
              @r = Rezlineitem.new
              @r.sectionid = params[:form][:section][i.to_s]
              puts "DEBUG quantity #{params[:form][:quantity][i.to_s]}. #{params[:form][:quantity][i.to_s].to_s}"
              @r.quantity = params[:form][:quantity][i.to_s]
              begin
                @qty+=@r.quantity.to_i
              rescue Exception => e
                puts "DEBUG caught exception #{e}"
              end
              @r.performance = params[:form][:performance][i.to_s]
              @r.rezid = @ticketrez.id
              puts "DEBUG tickets_controller#create nonajax rezlineitems: sectionid '#{@r.sectionid}', quantity '#{@r.quantity}', performance '#{@r.performance}', rezid '#{@r.rezid}'"
              if @r.save
                @rezlineitems.push(@r)
              else
                @sendemail=false
                @ticketrez.destroy
                @rezlineitems.each {|rez| rez.destroy}
              end
            end
            i=i+1
          end
          Mailer::deliver_rez_mail(@ticketrez.id) if @sendemail
        end #non-ajax makerez
      end # makerez
    end # request.post?
  end
  
  def sendemail
    Mailer::deliver_rez_mail(params[:ticketrezid])
  end
  
  def cancelrez
    @ticketrez = Ticketrez.find_by_hashid(params[:hashid])
    if @ticketrez.nil?
      redirect_to :action => "cancelerror"
    end
  end
  
  def destroyrez
    @ticketrez = Ticketrez.find(params[:ticketrez][:id])
    @show = Show.find_by_abbrev(@ticketrez.showid)
    @items = Rezlineitem.all(:conditions => ["rezid = ?", @ticketrez.id])
    @ticketrez.destroy
    @items.each {|i| i.destroy}
  end
protected
  def authorize
  end
end
