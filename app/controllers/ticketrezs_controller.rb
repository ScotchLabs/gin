class TicketrezsController < AdminController
  load_and_authorize_resource

  # GET /ticketrezs
  # GET /ticketrezs.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ticketrezs }
    end
  end

  # GET /ticketrezs/1
  # GET /ticketrezs/1.xml
  def show
    authorize! :read, Rezlineitem
    @rezlineitems = @ticketrez.rezlineitems
    @show = @ticketrez.show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticketrez }
    end
  end

  # GET /ticketrezs/new
  # GET /ticketrezs/new.xml
  def new
    @show = Show.find_by_abbrev(params[:abbrev])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticketrez }
    end
  end

  # GET /ticketrezs/1/edit
  def edit
    @show = @ticketrez.show
  end

  # POST /ticketrezs
  # POST /ticketrezs.xml
  def create
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
    authorize! :destroy, Rezlineitem
    @show = @ticketrez.show
    @ticketrez.destroy

    respond_to do |format|
      format.html { redirect_to(@show) }
      format.xml  { head :ok }
    end
  end
end
