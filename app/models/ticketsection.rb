class Ticketsection < ActiveRecord::Base
  belongs_to :show
  has_many :ticketrezs
  
  validates_presence_of :showid, :pricewithid, :pricewoutid, :size, :name
  validates_inclusion_of :showid, :in => Show.all.map {|show| show.abbrev }
  validate :name_ok
  
  def numreserved
    #TODO
  end
  
  def numavailable
    size-numreserved
  end
  
  def soldout
    numreserved==size
  end
  
private
  def name_ok
    errors.add(:name, "not unique for this show") if Ticketsection.all(:conditions => ["showid = ? AND name != ?",showid, name]).include?(name) 
  end
end
