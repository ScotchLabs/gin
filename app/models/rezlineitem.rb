class Rezlineitem < ActiveRecord::Base
  belongs_to :ticketrez
  
  validates_presence_of :rezid, :performance, :sectionid, :quantity
  validates_numericality_of :quantity
  validates_inclusion_of :rezid, :in => Ticketrez.all.map{|t| t.id }
  validate :sectionid_ok
  validate :performance_ok
private
  def sectionid_ok
    m=Ticketsection.all(:conditions => ["showid = ?", Ticketrez.find(rezid).showid]).map{|t| t.id.to_i }
    puts "DEBUG rezlineitem_model#sectionid_ok: available sections are "+m.join(", ")+". sectionid is '#{sectionid}'"
    errors.add(:sectionid, "does not exist for this show") unless m.include?(sectionid.to_i)
  end
  def performance_ok
    m=Show.first(:conditions => ["abbrev = ?",Ticketrez.find(rezid).showid]).performancetimes.split("|").map {|p| DateTime.parse(p)}
    errors.add(:performance, "does not exist for this show") unless m.include?(DateTime.parse(performance))
  end
end
