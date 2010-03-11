class RezlineitemsController < ApplicationController
  layout 'admin'
  # GET /rezlineitems/1
  # GET /rezlineitems/1.xml
  def show
    @rezlineitem = Rezlineitem.find(params[:id])
    @ticketrez = Ticketrez.find_by_id(@rezlineitem.rezid)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rezlineitem }
    end
  end

  # GET /rezlineitems/new
  # GET /rezlineitems/new.xml
  def new
    @ticketrez = Ticketrez.find_by_id(params[:ticketrezid])
    @rezlineitem = Rezlineitem.new
    @show = Show.find_by_abbrev(@ticketrez.showid)
    @ticketsections = Ticketsection.all(:conditions => ["showid = ?", @show.abbrev])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rezlineitem }
    end
  end

  # GET /rezlineitems/1/edit
  def edit
    @rezlineitem = Rezlineitem.find(params[:id])
    @ticketrez = Ticketrez.find(@rezlineitem.rezid)
    @show = Show.find_by_abbrev(@ticketrez.showid)
    puts "DEBUG rezlineitems_controller#edit: show '#{@show}', ticketrez.showid '#{@ticketrez.showid}'"
    @ticketsections = Ticketsection.all(:conditions => ["showid = ?", @show.abbrev])
  end

  # POST /rezlineitems
  # POST /rezlineitems.xml
  def create
    @rezlineitem = Rezlineitem.new(params[:rezlineitem])
    puts "DEBUG rezlineitems_controller#create: making a new lineitem for reservation '#{Ticketrez.find(@rezlineitem.rezid)}'"

    respond_to do |format|
      if @rezlineitem.save
        flash[:notice] = 'Rezlineitem was successfully created.'
        format.html { redirect_to(@rezlineitem) }
        format.xml  { render :xml => @rezlineitem, :status => :created, :location => @rezlineitem }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rezlineitem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rezlineitems/1
  # PUT /rezlineitems/1.xml
  def update
    @rezlineitem = Rezlineitem.find(params[:id])
    @ticketrez = Ticketrez.find(@rezlineitem.rezid)
    @show = Show.find_by_abbrev(@ticketrez.showid)
    puts "DEBUG rezlineitems_controller#update: show '#{@show}', ticketrez.showid '#{@ticketrez.showid}'"
    puts "DEBUG rezlineitems_controller#update: sectionid '#{@rezlineitem.sectionid}', sections available "+Ticketsection.all.map{|t| t.id }.join(", ")
    @ticketsections = Ticketsection.all(:conditions => ["showid = ?", @show.abbrev])

    respond_to do |format|
      if @rezlineitem.update_attributes(params[:rezlineitem])
        flash[:notice] = 'Rezlineitem was successfully updated.'
        format.html { redirect_to(@rezlineitem) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rezlineitem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rezlineitems/1
  # DELETE /rezlineitems/1.xml
  def destroy
    @rezlineitem = Rezlineitem.find(params[:id])
    @rezlineitem.destroy

    respond_to do |format|
      format.html { redirect_to(rezlineitems_url) }
      format.xml  { head :ok }
    end
  end
end
