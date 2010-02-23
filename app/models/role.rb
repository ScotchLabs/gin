class Role < ActiveRecord::Base
  has_many :roleassocs
  def crudshows
    ((crudcshows?)? "c":"")+((crudrshows?)? "r":"")+((crudushows?)? "u":"")+((cruddshows?)? "d":"")
  end
  
  def crudupdates
    ((crudcupdates?)? "c":"")+((crudrupdates?)? "r":"")+((cruduupdates?)? "u":"")+((cruddupdates?)? "d":"")
  end

  def crudcontents
    ((crudccontents?)? "c":"")+((crudrcontents?)? "r":"")+((cruducontents?)? "u":"")+((cruddcontents?)? "d":"")
  end
  
  def crudroles
    ((crudcroles?)? "c":"")+((crudrroles?)? "r":"")+((cruduroles?)? "u":"")+((cruddroles?)? "d":"")
  end
  
  def crudusers
    ((crudcusers?)? "c":"")+((crudrusers?)? "r":"")+((cruduusers?)? "u":"")+((cruddusers?)? "d":"")
  end
  
  def crudroleassocs
    ((crudcroleassocs?)? "c":"")+((crudrroleassocs?)? "r":"")+((cruduroleassocs?)? "u":"")+((cruddroleassocs?)? "d":"")
  end
end
