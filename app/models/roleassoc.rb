class Roleassoc < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  
  validates_presence_of :roleid, :userid
  validates_inclusion_of :roleid, :in => Role.all.map{|r| r.rabbrev}
  validates_inclusion_of :userid, :in => User.all.map{|u| u.name}
end
