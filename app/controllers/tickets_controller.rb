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
      @ticketrezdidntsave = false
      @rezlineitemdidntsave = false
      @emailsent = false
      ###############
      ## TICKETREZ ##
      ###############
      @ticketrez = Ticketrez.new
      @makerez=true
      #@sendemail=true
      @ajax=false
      if !params[:ticketrez][0].nil?
        ##########
        ## AJAX ##
        ##########
        @ajax=true
        @ticketrez.showid = params[:ticketrez][0]
        @ticketrez.name = params[:ticketrez][1]
        @ticketrez.email = params[:ticketrez][2]
        @ticketrez.hasid = params[:ticketrez][3]
        unless @ticketrez.save
          @ticketrezdidntsave = true
          @makerez=false
          #@sendemail=false
        end
      else
        #############
        ## NONAJAX ##
        #############
        @ticketrez = Ticketrez.new(params[:ticketrez])
        unless @ticketrez.save
          @ticketrezdidntsave = true
          @makerez=false
          #@sendemail=false
        end
      end # non-ajax ticketrez
      @show = Show.find_by_abbrev(@ticketrez.showid)
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
            @r.rezid = @ticketrez.id
            @r.performance = rli[0]
            @r.sectionid = rli[1]
            @r.quantity = rli[2]
            @qty+=@r.quantity
            if @r.save
              @rezlineitems.push(@r)
            else
              @rezlineitemsdidntsave = true
              #@sendemail=false
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
            unless params[:form][:quantity][i].blank?
              @r = Rezlinitem.new
              @r.sectionid = params[:form][:section][i]
              @r.quantity = params[:form][:quantity][i]
              @qty+=@r.quantity
              @r.performance = params[:form][:performance][i]
              @r.showid = params[:ticketrez][:showid]
              if @r.save
                @rezlineitems.push(@r)
              else
                #@sendemail=false
                @ticketrez.destroy
                @rezlineitems.each {|rez| rez.destroy}
              end
            end
            i=i+1
          end
          Mailer::deliver_rez_mail(@ticketrez.id)
        end #non-ajax makerez
      end # makerez
      #if @sendemail
      #  unless @ticketrez.email.nil? or @ticketrez.email.blank?
      #    Mailer::deliver_rez_mail(@ticketrez)
      #    @emailsent = true
      #  end
      #end
    end # request.post?
  end
  
  def sendemail
    Mailer::deliver_rez_mail(params[:ticketrezid])
  end
  
  def cancelrez
    @ticketrez = Ticketrez.find_by_hashid(params[:hashid])
    redirect_to :action => "cancelerror" if @ticketrez.nil?
  end
  
  def destroyrez
    @ticketrez = Ticketrez.find(params[:ticketrez][:id])
    @items = Rezlineitem.all(:conditions => ["rezid = ?", @ticketrez.id])
    @ticketrez.destroy
    @items.each {|i| i.destroy}
  end
protected
  def authorize
  end
end
