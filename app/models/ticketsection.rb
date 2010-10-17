class Ticketsection < ActiveRecord::Base
  belongs_to :show
  has_many :rezlineitems, :dependent => :destroy
  
  validates_presence_of :show, :pricewithid, :pricewoutid, :size, :name
  validates_uniqueness_of :name, :scope => :show_id
  #validate :seatingmap_ok
  
  def to_s
    name
  end
  
  def numreserved(performance=nil)
    perf = DateTime.parse(performance).to_s unless performance.nil?
    total = 0
    for i in rezlineitems
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
  
  def seatingmap_ok
    t=Ticketsection.all(:conditions => ["show_id = ? AND id != ?",show_id,id])
    s=show.seatingmap
    # if this is the second section for this show, make sure the show has a seatingmap
    errors.add(:show, "does not have a seating map!") if t.count == 1 and (s.blank? or s.nil?)
  end
end
