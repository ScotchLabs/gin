class TicketsectionsController < AdminController
  load_and_authorize_resource

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
    @show = @ticketsection.show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticketsection }
    end
  end

  # GET /ticketsections/new
  # GET /ticketsections/new.xml
  def new
    @show = Show.find_by_abbrev(params[:abbrev])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticketsection }
    end
  end

  # GET /ticketsections/1/edit
  def edit
    @show = @ticketsection.show
  end

  # POST /ticketsections
  # POST /ticketsections.xml
  def create
    @show = @ticketsection.show

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
    @show = @ticketsection.show

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
    authorize! :destroy, Rezlineitem
    @show = @ticketsection.show
    @ticketsection.destroy
    

    respond_to do |format|
      format.html { redirect_to(@show) }
      format.xml  { head :ok }
    end
  end
end
