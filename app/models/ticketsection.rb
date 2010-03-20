class Ticketsection < ActiveRecord::Base
  belongs_to :show
  has_many :ticketrezs
  
  validates_presence_of :showid, :pricewithid, :pricewoutid, :size, :name
  validates_inclusion_of :showid, :in => Show.all.map {|show| show.abbrev }
  validate :name_ok
  validate :seatingmap_ok
  
  def numreserved(performance=nil)
    r = nil
    if performance.nil?
      r = Rezlineitem.all(:conditions => ["sectionid = ?",id])
    else
      perf = DateTime.parse(performance).to_s
      r = Rezlineitem.all(:conditions => ["sectionid = ?",id])
    end
    total = 0
    for i in r
      if performance.nil? 
        total += i.quantity
      elsif DateTime.parse(i.performance)==perf
        total += i.quantity
      end
    end
    total
  end
  
  def numavailable(performance=nil)
    size-numreserved(performance)
  end
  
  def soldout(performance=nil)
    numreserved(performance)==size
  end
  
private

  def name_ok
    errors.add(:name, "not unique for this show") if Ticketsection.all(:conditions => ["showid = ? AND name != ?",showid, name]).include?(name) 
  end
  
  def seatingmap_ok
    t=Ticketsection.all(:conditions => ["showid = ? AND id != ?",showid,id])
    s=Show.find_by_abbrev(showid).seatingmap
    puts "DEBUG ticketsection_model#seatingmap_ok: numticketsections = '#{t.count}', seatingmap = '#{s}'"
    # if this is the second section for this show, make sure the show has a seatingmap
    errors.add(:show, "does not have a seating map!") if t.count == 1 and (s.blank? or s.nil?)
  end
end
