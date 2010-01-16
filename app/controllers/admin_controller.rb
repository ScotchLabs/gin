class AdminController < ApplicationController
  def login
    session[:crud] = Hash.new(4)
    session[:crud]["c"] = Hash.new(6)
    session[:crud]["c"]["contents"] = false
    session[:crud]["c"]["shows"] = false
    session[:crud]["c"]["users"] = false
    session[:crud]["c"]["updates"] = false
    session[:crud]["c"]["roles"] = false
    session[:crud]["c"]["roleassocs"] = false
    session[:crud]["r"] = Hash.new(6)
    session[:crud]["r"]["contents"] = false
    session[:crud]["r"]["shows"] = false
    session[:crud]["r"]["users"] = false
    session[:crud]["r"]["updates"] = false
    session[:crud]["r"]["roles"] = false
    session[:crud]["r"]["roleassocs"] = false
    session[:crud]["u"] = Hash.new(6)
    session[:crud]["u"]["contents"] = false
    session[:crud]["u"]["shows"] = false
    session[:crud]["u"]["users"] = false
    session[:crud]["u"]["updates"] = false
    session[:crud]["u"]["roles"] = false
    session[:crud]["u"]["roleassocs"] = false
    session[:crud]["d"] = Hash.new(6)
    session[:crud]["d"]["contents"] = false
    session[:crud]["d"]["shows"] = false
    session[:crud]["d"]["users"] = false
    session[:crud]["d"]["updates"] = false
    session[:crud]["d"]["roles"] = false
    session[:crud]["d"]["roleassocs"] = false
    puts "DEBUG admin_controller: user logging in..."
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if !user.nil?
        session[:user_id] = user.id
        session[:user_name] = user.name
        puts "DEBUG admin_controller: user '#{session[:user_name]}' exists"
        roleassocs = Roleassoc.all(:conditions => ["userid = ?", user.name])
        for roleassoc in roleassocs
          puts "DEBUG admin_controller: user '#{session[:user_name]}' has a role as '#{roleassoc.roleid}'"
          role = Role.first(:conditions => ["abbrev = ?", roleassoc.roleid])
          puts "DEBUG admin_controller: role '#{roleassoc.roleid}' "+((!role.nil?)? "exists":"does not exist")
          session[:crud]["c"]["contents"] = role.crudccontents || session["c"]["contents"]
          session[:crud]["c"]["shows"] = role.crudcshows || session[:crud]["c"]["shows"]
          session[:crud]["c"]["users"] = role.crudcusers || session[:crud]["c"]["users"]
          session[:crud]["c"]["updates"] = role.crudcupdates || session[:crud]["c"]["updates"]
          session[:crud]["c"]["roles"] = role.crudcroles || session[:crud]["c"]["roles"]
          session[:crud]["c"]["roleassocs"] = role.crudcroleassocs || session[:crud]["c"]["roleassocs"]
          session[:crud]["r"]["contents"] = role.crudrcontents || session["r"]["contents"]
          session[:crud]["r"]["shows"] = role.crudrshows || session[:crud]["r"]["shows"]
          session[:crud]["r"]["users"] = role.crudrusers || session[:crud]["r"]["users"]
          session[:crud]["r"]["updates"] = role.crudrupdates || session[:crud]["r"]["updates"]
          session[:crud]["r"]["roles"] = role.crudrroles || session[:crud]["r"]["roles"]
          session[:crud]["r"]["roleassocs"] = role.crudrroleassocs || session[:crud]["r"]["roleassocs"]
          session[:crud]["u"]["contents"] = role.cruducontents || session[:crud]["u"]["contents"]
          session[:crud]["u"]["shows"] = role.crudushows || session[:crud]["u"]["shows"]
          session[:crud]["u"]["users"] = role.cruduusers || session[:crud]["u"]["users"]
          session[:crud]["u"]["updates"] = role.crudupdates || session[:crud]["u"]["updates"]
          session[:crud]["u"]["roles"] = role.cruduroles || session[:crud]["u"]["roles"]
          session[:crud]["u"]["roleassocs"] = role.cruduroleassocs || session[:crud]["u"]["roleassocs"]
          session[:crud]["d"]["contents"] = role.cruddcontents || session[:crud]["d"]["contents"]
          session[:crud]["d"]["shows"] = role.cruddshows || session[:crud]["d"]["shows"]
          session[:crud]["d"]["users"] = role.cruddusers || session[:crud]["d"]["users"]
          session[:crud]["d"]["updates"] = role.cruddupdates || session[:crud]["d"]["updates"]
          session[:crud]["d"]["roles"] = role.cruddroles || session[:crud]["d"]["roles"]
          session[:crud]["d"]["roleassocs"] = role.cruddroleassocs || session[:crud]["d"]["roleassocs"]
        end
        puts "DEBUG admin_controller: session crud is "+session[:crud].to_s
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || { :action => "welcome" })
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    session[:display_mode] = nil
    session[:crud] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end

  def index
    redirect_to :action => "welcome"
  end
  
  def publicview
    session[:display_mode] = "public"
    redirect_to root_url
  end
  
  def fullview
    session[:display_mode] = "full"
    redirect_to root_url
  end
end
