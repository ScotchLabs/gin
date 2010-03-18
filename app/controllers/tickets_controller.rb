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
      puts "DEBUG tickets_controller#create: begin"
      ###############
      ## TICKETREZ ##
      ###############
      puts "processing ticketrez"
      @ticketrez = Ticketrez.new
      makerez=true
      sendemail=true
      ajax=false
      if !params[:ticketrez][0].nil?
        puts "ajax true"
        ##########
        ## AJAX ##
        ##########
        ajax=true
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
          makerez=false
          sendemail=false
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
          makerez=false
          sendemail=false
          @message = "Your ticket reservation information was invalid:"
        end
      end # non-ajax ticketrez
      #############
      ## MESSAGE ##
      #############
      puts "building message for ticketrez"
      if @ticketrez.name.nil? or @ticketrez.name.blank?
        puts "name was nil or blank"
        @message += "<br />Name field is required."
      end
      if @ticketrez.phone.nil? or @ticketrez.phone.blank?
        puts "phone was nil or blank"
        @message += "<br />Phone field is required."
      elsif (@ticketrez.phone=~/^(?:(1)?\s*[-\/\.]?)?(?:\((\d{3})\)|(\d{3}))\s*[-\/\.]?\s*(\d{3})\s*[-\/\.]?\s*(\d{4})\s*(?:(?:[xX]|[eE][xX][tT])\.?\s*(\d+))*$/).nil?
        puts "phone didn't parse"
        @message += "<br />Phone number '#{@ticketrez.phone}' is invalid."
      end
      if !@ticketrez.email.nil? and !@ticketrez.email.blank? and (@ticketrez.email=~/[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/).nil?
        puts "email didn't parse"
        @message += "<br />Email address '#{@ticketrez.email}' is invalid."
      end
      if @ticketrez.hasid.nil? or @ticketrez.hasid.blank?
        puts "hasid nil or blank"
        @message += "<br />ID field is required."
      end
      ta=Ticketrez.all(:conditions => ["showid = ?", @ticketrez.showid])
      for other in ta
        if other.id!=@ticketrez.id and other.unformattedphone == @ticketrez.unformattedphone
          puts "conflicting reservation (this.unformattedphone==#{@ticketrez.unformattedphone}, other.unformattedphone==#{other.unformattedphone}"
          @message += "<br />There is already a reservation for this phone number. If you wish to change or cancel your reservation go to the url you were given at the time you reserved your tickets. Contact the <a href='mailto:webmaster@snstheatre.org'>system administrator</a> if you're having trouble."
        end
      end
      @message += "<br /><a href='/tickets/show/#{params[:backto]}'>Back</a>" unless ajax
      puts "ticketrez message built"
      if makerez
        puts "processing rezlineitems"
        ##################
        ## REZLINEITEMS ##
        ##################
        @rezlineitems = Array.new
        qty=0
        if !params[:rezlineitems].nil?
          puts "ajax true"
          ajax=true
          ##########
          ## AJAX ##
          ##########
          for rli in params[:rezlineitems]
            rli = rli.split("|")
            r = Rezlineitem.new
            r.rezid = @ticketrez.id
            r.performance = rli[0]
            r.sectionid = rli[1]
            r.quantity = rli[2]
            qty+=r.quantity
            puts "rezlineitem info: rezid:'#{r.rezid}', performance:'#{r.performance}', sectionid:'#{r.sectionid}', quantity:'#{r.quantity}'"
            if r.save
              puts "rezlineitem saved"
              @rezlineitems.push(r)
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
          ajax=false
          i=0
          while i<params[:form][:section].length
            unless params[:form][:quantity][i].blank?
              r = Rezlinitem.new
              r.sectionid = params[:form][:section][i]
              r.quantity = params[:form][:quantity][i]
              qty+=r.quantity
              r.performance = params[:form][:performance][i]
              r.showid = params[:ticketrez][:showid]
              puts "rezlineitem info: rezid:'#{r.rezid}', performance:'#{r.performance}', sectionid:'#{r.sectionid}', quantity:'#{r.quantity}'"
              if r.save
                puts "rezlineitem saved"
                @rezlineitems.push(r)
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
        #############
        ## MESSAGE ##
        #############
        puts "building rezlineitem message"
        @message = "<br />One or more of your ticket quantities was invalid."
        unless r.quantity.nil? or r.quantity.blank?
          if r.quantity==0
            puts "quantity was 0"
          elsif r.quantity.to_f.nan?
            puts "quantity NaN"
            @message += "<br />Quantity is not a number."
          end
          section=Ticketsection.find(r.sectionid)
          unless section.nil? or r.performance.nil? or r.performance.blank?
            if r.quantity>section.numavailable(r.performance)
              puts "quantity>numavailable"
              @message += "<br />Quantity was over number of tickets available for that section and performance."
            end
          else
            puts "section is nil (#{section.nil?}), performance was nil (#{r.performance.nil?}), or performance was blank (#{r.performance.blank?})"
          end
        end
        if section.nil?
          puts "section nil"
          @message += "<br />Section ID is invalid. Please contact the <a href='mailto:webmaster@snstheatre.org'>system administrator</a>."
        end
        s=Show.find_by_abbrev(section.showid)
        if s.nil?
          puts "show nil"
          @message += "<br />Show ID is invalid. Please contact the <a href='mailto:webmaster@snstheatre.org'>system administrator</a>."
        else
          perfs=s.performancetimes.split("|")
          foundperf=false
          for perf in perfs
            foundperf=true if DateTime.parse(perf)==DateTime.parse(r.performance)
          end
          unless foundperf
            puts "couldn't find perf"
            @message += "<br />Performance selection was invalid. Please contact the <a href='mailto:webmaster@snstheatre.org'>system administrator</a>."
          end
        end
        if qty==0
          puts "total qty 0"
          @message += "<br />Ticket quantities are required."
        end
        @message += "<br /><a href='/tickets/show/#{params[:backto]}'>Back</a>" unless ajax
        puts "built rezlineitem message"
      end # makerez
      if sendemail
        puts "sending email"
        @message += "<br />The ID for your reservation is #{@ticketrez.hashid}<br />In order to edit or cancel your reservation, visit this link: <a href='http://snstheatre.org/tickets/edit/#{@ticketrez.hashid}'>http://snstheatre.org/tickets/edit/#{@ticketrez.hashid}</a>"
        unless @ticketrez.email.nil? or @ticketrez.email.blank?
          #TODO actually send an email
          @message += "<br />An email receipt has been sent to #{@ticketrez.email}"
        else
          @message += "<br />You didn't input an email address, so keep track of this ID in case you ever want to change your reservation."
        end
        puts "to be implemented"
      end
    end # request.post?
    puts "DEBUG tickets_controller#create: end"
    puts "=============================================================================================================================================="
  end
  
  def edit
    #TODO
  end
protected
  def authorize
  end
end
