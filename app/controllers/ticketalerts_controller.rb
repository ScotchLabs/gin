class TicketalertsController < AdminController
  load_and_authorize_resource

  # GET /ticketalerts
  # GET /ticketalerts.xml
  def index
    @ticketalerts = Ticketalert.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ticketalerts }
    end
  end

  # GET /ticketalerts/1
  # GET /ticketalerts/1.xml
  def show
    @show = @ticketalert.show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticketalert }
    end
  end

  # GET /ticketalerts/new
  # GET /ticketalerts/new.xml
  def new
    @show = @ticketalert.show

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticketalert }
    end
  end

  # GET /ticketalerts/1/edit
  def edit
    @show = @ticketalert.show
  end

  # POST /ticketalerts
  # POST /ticketalerts.xml
  def create
    @show = @ticketalert.show

    respond_to do |format|
      if @ticketalert.save
        flash[:notice] = 'Ticketalert was successfully created.'
        format.html { redirect_to(@ticketalert) }
        format.xml  { render :xml => @ticketalert, :status => :created, :location => @ticketalert }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ticketalert.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ticketalerts/1
  # PUT /ticketalerts/1.xml
  def update
    respond_to do |format|
      if @ticketalert.update_attributes(params[:ticketalert])
        flash[:notice] = 'Ticketalert was successfully updated.'
        format.html { redirect_to(@ticketalert) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticketalert.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ticketalerts/1
  # DELETE /ticketalerts/1.xml
  def destroy
    @show = @ticketalert.show
    @ticketalert.destroy

    respond_to do |format|
      format.html { redirect_to(@show) }
      format.xml  { head :ok }
    end
  end
end
