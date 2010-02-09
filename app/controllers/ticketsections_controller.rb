class TicketsectionsController < ApplicationController
  layout 'admin'
  # GET /ticketsections
  # GET /ticketsections.xml
  def index
    @ticketsections = Ticketsection.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ticketsections }
    end
  end

  # GET /ticketsections/1
  # GET /ticketsections/1.xml
  def show
    @ticketsection = Ticketsection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticketsection }
    end
  end

  # GET /ticketsections/new
  # GET /ticketsections/new.xml
  def new
    @ticketsection = Ticketsection.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticketsection }
    end
  end

  # GET /ticketsections/1/edit
  def edit
    @ticketsection = Ticketsection.find(params[:id])
  end

  # POST /ticketsections
  # POST /ticketsections.xml
  def create
    @ticketsection = Ticketsection.new(params[:ticketsection])

    respond_to do |format|
      if @ticketsection.save
        flash[:notice] = 'Ticketsection was successfully created.'
        format.html { redirect_to(@ticketsection) }
        format.xml  { render :xml => @ticketsection, :status => :created, :location => @ticketsection }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ticketsection.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ticketsections/1
  # PUT /ticketsections/1.xml
  def update
    @ticketsection = Ticketsection.find(params[:id])

    respond_to do |format|
      if @ticketsection.update_attributes(params[:ticketsection])
        flash[:notice] = 'Ticketsection was successfully updated.'
        format.html { redirect_to(@ticketsection) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticketsection.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ticketsections/1
  # DELETE /ticketsections/1.xml
  def destroy
    @ticketsection = Ticketsection.find(params[:id])
    @ticketsection.destroy

    respond_to do |format|
      format.html { redirect_to(ticketsections_url) }
      format.xml  { head :ok }
    end
  end
end
