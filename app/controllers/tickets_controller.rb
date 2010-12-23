class TicketsController < ApplicationController
  layout 'index'
  def index
    authorize! :create, Ticketrez, Rezlineitem
    @shows = Show.all
    @shows.sort! { |x, y| Time.parse(x.performancetimes.split("|")[0])<=>Time.parse(y.performancetimes.split("|")[0]) }
    @shows.reverse.each { |show| @activeshow = show if show.upcoming and show.ticketstatus=="open" and !show.ticketsections.empty? }
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
    authorize! :create, Ticketrez, Rezlineitem
    @ticketrez = Ticketrez.new
    # find a show with params[:abbrev], else redirect to tickets/showerror
    @show = Show.find_by_abbrev(params[:abbrev])
    if @show.nil?
      redirect_to "/tickets/showerror"
    else
      @ticketsections = @show.ticketsections
    end
    
    if @ticketsections.empty? or !@show.upcoming
      redirect_to "/tickets/showclosed"
    end
      
    @ticketrez = Ticketrez.new
    
    @errors = Array.new
    if params[:highlight]
      @errors=params[:highlight].split("/")
    end
  end
  
  def create
    authorize! :create, Ticketrez, Rezlineitem
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
      @ticketrez = Ticketrez.new(params[:ticketrez])
      unless @ticketrez.save
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
        i=0
        while i<params[:form][:section].length
          unless params[:form][:quantity][i.to_s].blank?
            @r = Rezlineitem.new
            @r.ticketsection_id = params[:form][:section][i.to_s]
            @r.quantity = params[:form][:quantity][i.to_s]
            begin
              @qty+=@r.quantity.to_i
            rescue Exception => e
              # caught exception
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
        if @sendemail
          UserMailer.rez(@ticketrez).deliver
          @ticketrez.email_sent = true
          @ticketrez.save
        end
      end # makerez
      
      @errors = @ticketrez.errors.map{|e| e[0]}
      for er in @rezlineitemerrors
        @errors << er[0]
      end
      @errors << "quantity" if @qty==0 and !@ticketrezdidntsave
      @errors = @errors.uniq.join("|")
      
      if @ticketrezdidntsave or @rezlineitemdidntsave
        redirect_to "/tickets/show/#{@show.abbrev}/?highlight=name/email"
      end
    end # request.post?
  end
  
  def sendemail
    begin
      @ticketrez = Ticketrez.find_by_id(params[:id])
    rescue RecordNotFound
      flash[:notice] = "We couldn't find a reservation with that id."
      redirect_to "/admin"
    end
    if @ticketrez
      UserMailer.rez(@ticketrez).deliver
      @ticketrez.email_sent = true
      @ticketrez.save
      flash[:notice] = "An email was sent to #{@ticketrez.email} with his or her reservation details."
      redirect_to @ticketrez.show
    else
      flash[:notice] = "We couldn't find a reservation with that id."
      redirect_to "/admin"
    end
  end
  
  def cancelrez
    @ticketrez = Ticketrez.find_by_hashid(params[:hashid])
    if @ticketrez.nil?
      redirect_to :action => "cancelerror"
    end
  end
  
  def destroyrez
    @ticketrez = Ticketrez.find(params[:ticketrez][:id])
    @show = @ticketrez.show
    @ticketrez.canceled = true
    @ticketrez.save
  end
end
