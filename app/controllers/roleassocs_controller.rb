class RoleassocsController < ApplicationController
  layout 'admin'
  # GET /roleassocs
  # GET /roleassocs.xml
  def index
    @roleassocs = Roleassoc.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @roleassocs }
    end
  end

  # GET /roleassocs/1
  # GET /roleassocs/1.xml
  def show
    @roleassoc = Roleassoc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @roleassoc }
    end
  end

  # GET /roleassocs/new
  # GET /roleassocs/new.xml
  def new
    @roleassoc = Roleassoc.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @roleassoc }
    end
  end

  # GET /roleassocs/1/edit
  def edit
    @roleassoc = Roleassoc.find(params[:id])
  end

  # POST /roleassocs
  # POST /roleassocs.xml
  def create
    @roleassoc = Roleassoc.new(params[:roleassoc])

    respond_to do |format|
      if @roleassoc.save
        flash[:notice] = 'Roleassoc was successfully created.'
        format.html { redirect_to(@roleassoc) }
        format.xml  { render :xml => @roleassoc, :status => :created, :location => @roleassoc }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @roleassoc.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /roleassocs/1
  # PUT /roleassocs/1.xml
  def update
    @roleassoc = Roleassoc.find(params[:id])

    respond_to do |format|
      if @roleassoc.update_attributes(params[:roleassoc])
        flash[:notice] = 'Roleassoc was successfully updated.'
        format.html { redirect_to(@roleassoc) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @roleassoc.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /roleassocs/1
  # DELETE /roleassocs/1.xml
  def destroy
    @roleassoc = Roleassoc.find(params[:id])
    @roleassoc.destroy

    respond_to do |format|
      format.html { redirect_to(roleassocs_url) }
      format.xml  { head :ok }
    end
  end
end
