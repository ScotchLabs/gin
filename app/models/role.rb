class Role < ActiveRecord::Base
  has_many :roleassocs
  
  validate_inclusion_of :userid, :in => User.all.map{|u| u.name}
  validate_inclusion_of :roleid, :in => Role.all.map{|r| r.rabbrev}
end
