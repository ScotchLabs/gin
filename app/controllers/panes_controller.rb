class PanesController < ApplicationController
  layout 'admin'
  # GET /panes
  # GET /panes.xml
  def index
    @panes = Pane.all(:order => "panes.order ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @panes }
    end
  end

  # GET /panes/1
  # GET /panes/1.xml
  def show
    @pane = Pane.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pane }
    end
  end

  # GET /panes/new
  # GET /panes/new.xml
  def new
    @pane = Pane.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pane }
    end
  end

  # GET /panes/1/edit
  def edit
    @pane = Pane.find(params[:id])
  end

  # POST /panes
  # POST /panes.xml
  def create
    @pane = Pane.new(params[:pane])

    respond_to do |format|
      if @pane.save
        flash[:notice] = 'Pane was successfully created.'
        format.html { redirect_to(@pane) }
        format.xml  { render :xml => @pane, :status => :created, :location => @pane }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pane.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /panes/1
  # PUT /panes/1.xml
  def update
    @pane = Pane.find(params[:id])

    respond_to do |format|
      if @pane.update_attributes(params[:pane])
        flash[:notice] = 'Pane was successfully updated.'
        format.html { redirect_to(@pane) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pane.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /panes/1
  # DELETE /panes/1.xml
  def destroy
    @pane = Pane.find(params[:id])
    @pane.destroy

    respond_to do |format|
      format.html { redirect_to(panes_url) }
      format.xml  { head :ok }
    end
  end
end
