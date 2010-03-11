class Ticketsection < ActiveRecord::Base
  belongs_to :show
  has_many :ticketrezs
  
  validates_presence_of :showid, :pricewithid, :pricewoutid, :size, :name
  validates_inclusion_of :showid, :in => Show.all.map {|show| show.abbrev }
  validate :name_ok
  
  def numreserved(performance=nil)
    puts "\tDEBUG ticketsection_model#numreserved: checking how many tickets have been reserved for section '#{name}/#{id}' for show '#{showid}' for performance '#{performance}'"
    r = nil
    if performance.nil?
      r = Rezlineitem.all(:conditions => ["sectionid = ?",id])
    else
      perf = DateTime.parse(performance).to_s
      puts "\tDEBUG ticketsection_model#numreserved: Rezlineitem.all(:conditions => [\"sectionid = ? AND performance = ?\",#{id}, \"#{perf}\"])"
      r = Rezlineitem.all(:conditions => ["sectionid = ? AND performance = ?",id, perf])
    end
    total = 0
    for i in r
      puts "\t\tDEBUG found a rezlineitem with this sectionid"+((!performance.nil?)? (" and performance"):())+", quantity '#{i.quantity}'"
      total += i.quantity
    end
    puts "\tDEBUG ticketsection_model#numreserved: #{total}"
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
end
