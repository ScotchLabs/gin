class UpdatesController < AdminController
  load_and_authorize_resource

  # GET /updates
  # GET /updates.xml
  def index
    @updates = Update.find(:all, :order => "created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @updates }
    end
  end

  # GET /updates/1
  # GET /updates/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @update }
    end
  end

  # GET /updates/new
  # GET /updates/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @update }
    end
  end

  # GET /updates/1/edit
  def edit
  end

  # POST /updates
  # POST /updates.xml
  def create
    respond_to do |format|
      if @update.save
        flash[:notice] = 'Update was successfully created.'
        format.html { redirect_to(@update) }
        format.xml  { render :xml => @update, :status => :created, :location => @update }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @update.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /updates/1
  # PUT /updates/1.xml
  def update
    respond_to do |format|
      if @update.update_attributes(params[:update])
        flash[:notice] = 'Update was successfully updated.'
        format.html { redirect_to(@update) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @update.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /updates/1
  # DELETE /updates/1.xml
  def destroy
    @update.destroy

    respond_to do |format|
      format.html { redirect_to(updates_url) }
      format.xml  { head :ok }
    end
  end
end
