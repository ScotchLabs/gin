class TicketrezsController < ApplicationController
  layout 'admin'
  # GET /ticketrezs
  # GET /ticketrezs.xml
  def index
    @ticketrezs = Ticketrez.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ticketrezs }
    end
  end

  # GET /ticketrezs/1
  # GET /ticketrezs/1.xml
  def show
    @ticketrez = Ticketrez.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticketrez }
    end
  end

  # GET /ticketrezs/new
  # GET /ticketrezs/new.xml
  def new
    @ticketrez = Ticketrez.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticketrez }
    end
  end

  # GET /ticketrezs/1/edit
  def edit
    @ticketrez = Ticketrez.find(params[:id])
  end

  # POST /ticketrezs
  # POST /ticketrezs.xml
  def create
    @ticketrez = Ticketrez.new(params[:ticketrez])

    respond_to do |format|
      if @ticketrez.save
        flash[:notice] = 'Ticketrez was successfully created.'
        format.html { redirect_to(@ticketrez) }
        format.xml  { render :xml => @ticketrez, :status => :created, :location => @ticketrez }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ticketrez.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ticketrezs/1
  # PUT /ticketrezs/1.xml
  def update
    @ticketrez = Ticketrez.find(params[:id])

    respond_to do |format|
      if @ticketrez.update_attributes(params[:ticketrez])
        flash[:notice] = 'Ticketrez was successfully updated.'
        format.html { redirect_to(@ticketrez) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticketrez.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ticketrezs/1
  # DELETE /ticketrezs/1.xml
  def destroy
    @ticketrez = Ticketrez.find(params[:id])
    @ticketrez.destroy

    respond_to do |format|
      format.html { redirect_to(shows_url) }
      format.xml  { head :ok }
    end
  end
end