class Role < ActiveRecord::Base
  def crudshows
    out = ""
    out += (crudcshows?)? "c":""
    out += (crudrshows?)? "r":""
    out += (crudushows?)? "u":""
    out += (cruddshows?)? "d":""
  end
  
  def crudupdates
    out = ""
    out += (crudcupdates?)? "c":""
    out += (crudrupdates?)? "r":""
    out += (cruduupdates?)? "u":""
    out += (cruddupdates?)? "d":""
  end

  def crudcontents
    out = ""
    out += (crudccontents?)? "c":""
    out += (crudrcontents?)? "r":""
    out += (cruducontents?)? "u":""
    out += (cruddcontents?)? "d":""
  end
  
  def crudroles
    out = ""
    out += (crudcroles?)? "c":""
    out += (crudrroles?)? "r":""
    out += (cruduroles?)? "u":""
    out += (cruddroles?)? "d":""
  end
  
  def crudusers
    out = ""
    out += (crudcusers?)? "c":""
    out += (crudrusers?)? "r":""
    out += (cruduusers?)? "u":""
    out += (cruddusers?)? "d":""
  end
  
  def crudroleassocs
    out = ""
    out += (crudcroleassocs?)? "c":""
    out += (crudrroleassocs?)? "r":""
    out += (cruduroleassocs?)? "u":""
    out += (cruddroleassocs?)? "d":""
  end
end
