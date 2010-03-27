class RoleassocsController < AdminController
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
        puts "DEBUG roleassocs_controller#create: trying to send email to user '#{@roleassoc.userid}' about role '#{@roleassoc.roleid}'"
        u=User.find_by_name(@roleassoc.userid)
        r=Role.find_by_rabbrev(@roleassoc.roleid)
        puts "DEBUG roleassocs_controller#create: sending email to user '#{u}' about role '#{r}'"
        Mailer::deliver_approved_mail(u, r)
        Mailer::deliver_approved_admin_mail(u, r)
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
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
