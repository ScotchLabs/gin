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
    
    if (@show.ticketstatus != "open" and !session[:user_id]) or @ticketsections.empty?
      redirect_to "/tickets/showclosed"
    end
      
    @ticketrez = Ticketrez.new
    
    @errors = Array.new
    if params[:highlight]
      @errors=params[:highlight].split("|") 
    end
  end
  
  def create
    @rezlineitemerrors = Array.new
    @ticketrezerrors = Array.new
    @ticketrezdidntsave = false
    @rezlineitemdidntsave = false
    @rerrors = Array.new
    @qty = 0
    if request.post?
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
        show = Show.find(params[:ticketrez][0].to_i)
        if show.nil?
          raise "ShowNotFoundError"
        end
        @ticketrez.show_id = show.id
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
        puts @ticketrez.errors.full_messages.inspect
        @ticketrez.errors.full_messages.each do |msg|
          msg = msg.split("|")[1] if msg.index("|")
          @ticketrezerrors.push(msg)
        end
        @ticketrezdidntsave = true
        @makerez=false
        @sendemail=false
      end
      
      @show = @ticketrez.show
      if @makerez
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
            @r.ticketrez_id = @ticketrez.id
            @r.performance = rli[0]
            @r.ticketsection_id = rli[1]
            @r.quantity = rli[2]
            @qty+=@r.quantity
            if @r.save
              @rezlineitems.push(@r)
            else
              puts "DEBUG @r's errors: #{@r.errors.full_messages.inspect}"
              @r.errors.full_messages.each do |msg|
                msg = msg.split("|")[1] if msg.index("|")
                @rezlineitemerrors.push(msg)
              end
              @rezlineitemdidntsave = true
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
          @ajax=false
          i=0
          while i<params[:form][:section].length
            unless params[:form][:quantity][i.to_s].blank?
              @r = Rezlineitem.new
              @r.ticketsection_id = params[:form][:section][i.to_s]
              @r.quantity = params[:form][:quantity][i.to_s]
              begin
                @qty+=@r.quantity.to_i
              rescue Exception => e
                puts "DEBUG caught exception #{e}"
              end
              @r.performance = params[:form][:performance][i.to_s]
              @r.ticketrez_id = @ticketrez.id
              if @r.save
                @rezlineitems.push(@r)
              else
                @rerrors = @r.errors
                @r.errors.full_messages.each do |msg|
                  msg = msg.split("|")[1] if msg.index("|")
                  @rezlineitemerrors.push(msg)
                end
                @rezlineitemdidntsave = true
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
      
      if !@ajax and (@ticketrezdidntsave or @rezlineitemdidntsave)
        errors = @ticketrez.errors.map{|e| e[0]}
        for er in @rerrors
          errors << er[0]
        end
        errors << "quantity" if @qty==0
        errors = errors.uniq!.join("|")
        redirect_to "/tickets/show/#{@show.abbrev}?highlight=#{errors}"
        
      end
    end # request.post?
  end
  
  def sendemail
    Mailer::deliver_rez_mail(params[:ticketrezid])
  end
  
  def cancelrez
    @ticketrez = Ticketrez.find_by_hashid(params[:hashid])
    puts "DEBUG could we find a ticketrez? #{!@ticketrez.nil?}"
    if @ticketrez.nil?
      redirect_to :action => "cancelerror"
    end
  end
  
  def destroyrez
    @ticketrez = Ticketrez.find(params[:ticketrez][:id])
    @show = @ticketrez.show
    @ticketrez.destroy
  end
protected
  def authorize
  end
end
