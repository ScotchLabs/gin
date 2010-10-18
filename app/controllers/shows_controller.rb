class ShowsController < AdminController
  load_and_authorize_resource

  # GET /shows
  # GET /shows.xml
  def index
    @shows = Show.all
    @shows.sort! { |x, y| Time.parse(y.performancetimes.split("|")[0])<=>Time.parse(x.performancetimes.split("|")[0]) }
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shows }
    end
  end

  # GET /shows/1
  # GET /shows/1.xml
  def show
    authorize! if can? :read, [Show, Ticketalert, Ticketrez, Ticketsection]
    @ticketalerts = @show.ticketalerts
    @ticketrezs = @show.ticketrezs
    @ticketsections = @show.ticketsections

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @show }
    end
  end

  # GET /shows/new
  # GET /shows/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @show }
    end
  end

  # GET /shows/1/edit
  def edit
  end

  # POST /shows
  # POST /shows.xml
  def create
    respond_to do |format|
      if @show.save
        flash[:notice] = 'Show was successfully created.'
        format.html { redirect_to(@show) }
        format.xml  { render :xml => @show, :status => :created, :location => @show }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @show.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shows/1
  # PUT /shows/1.xml
  def update
    respond_to do |format|
      if @show.update_attributes(params[:show])
        flash[:notice] = 'Show was successfully updated.'
        format.html { redirect_to(@show) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @show.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shows/1
  # DELETE /shows/1.xml
  def destroy
    authorize! if can? :destroy, [Show, Ticketsection, Ticketrez, Rezlineitem, Ticketalert]
    @show.destroy

    respond_to do |format|
      format.html { redirect_to(shows_url) }
      format.xml  { head :ok }
    end
  end
end
