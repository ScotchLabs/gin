module AdminHelper
  def hasaccess?(u,controller,action)
    user = User.find_by_name(u)
    puts "DEBUG AdminHelper#hasaccess: user '#{u.name}' controller '#{controller}', action '#{action}'"
    if action == "index" || action == "show"
      crud = "r"
    elsif action == "edit" || action == "update"
      crud = "u"
    elsif action == "new" || action == "create"
      crud = "c"
    elsif action == "destroy"
      crud = "d"
    end
    if (user.nil? or controller.nil? or controller.blank? or crud.nil?)
      @controller.send(false)
    end
    if !session[:user_permissions].nil? and !session[:user_permissions]["#{controller}"].nil? and !session[:user_permissions]["#{controller}"]["#{crud}"].nil?
      @controller.send(session[:user_permissions]["#{controller}"]["#{crud}"])
    end
    access = false
    roleassocs = Roleassoc.all(:conditions => ["userid = ?",user.name])
    for roleassoc in roleassocs
      role = Role.find_by_rabbrev(roleassoc.roleid)
      #somehow get the controller crud out of role
      puts "DEBUG AdminHelper#hasaccess: role '#{role}', controller '#{controller}', crud '#{crud}'"
      access = access || (!role.send("r"+controller).nil? && role.send("r"+controller).include?(crud))
      puts "DEBUG AdminHelper#hasaccess: access after role #{access}"
      break if access
    end
    if session[:user_permissions].nil?
      session[:user_permissions] = Hash.new
    elsif session[:user_permissions]["#{controller}"].nil?
      session[:user_permissions]["#{controller}"] = Hash.new
    else
      session[:user_permissions]["#{controller}"]["#{crud}"] = access
    end
    @controller.send(access)
  end
end
