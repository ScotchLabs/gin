class Ticketsection < ActiveRecord::Base
  belongs_to :show
  has_many :ticketrezs
  
  validates_presence_of :showid, :pricewithid, :pricewoutid, :size, :name
  validates_inclusion_of :showid, :in => Show.all.map {|show| show.abbrev }
  validate :name_ok
  
  def numreserved
    rezzes = Ticketrez.all(:conditions => ["showid = ? AND sectioninfo LIKE ?", showid, "%"+name+"%"])
    num = 0
    for rez in rezzes
      info = rez.sectioninfo.split("|")
      sectionnames = info.map {|i| i.split(":")[0] }
      sectionqties = info.map {|i| i.split(":")[1] }
      if !sectionnames.index(name).nil?
        num += sectionqties[sectionnames.index(name)]
      end
    end
    num
  end
  
  def numavailable
    size-numreserved
  end
  
  def soldout
    numreserved==size
  end
  
private
  def name_ok
    errors.add(:name, "not unique for this show") if Ticketsection.all(:conditions => ["showid = ?",showid]).map {|rez| rez.name}.include?(name)
  end
end
