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
  
  def crudpanes
    out = ""
    out += (crudcpanes?)? "c":""
    out += (crudrpanes?)? "r":""
    out += (crudupanes?)? "u":""
    out += (cruddpanes?)? "d":""
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
  
  def crudcategories
    out = ""
    out += (crudccategories?)? "c":""
    out += (crudrcategories?)? "r":""
    out += (cruducategories?)? "u":""
    out += (cruddcategories?)? "d":""
  end
  
  def crudtopics
    out = ""
    out += (crudctopics?)? "c":""
    out += (crudrtopics?)? "r":""
    out += (crudutopics?)? "u":""
    out += (cruddtopics?)? "d":""
  end
  
  def crudposts
    out = ""
    out += (crudcposts?)? "c":""
    out += (crudrposts?)? "r":""
    out += (cruduposts?)? "u":""
    out += (cruddposts?)? "d":""
  end
end
