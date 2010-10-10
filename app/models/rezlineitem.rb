class Rezlineitem < ActiveRecord::Base
  belongs_to :ticketrez
  belongs_to :ticketsection
  
  validates_presence_of :ticketrez, :ticketsection, :performance, :quantity
  validates_numericality_of :quantity, :greater_than => 0
  validate :ticketsection_ok
  validate :performance_ok
  validate :quantity_ok
  
  def quantity=(foo)
    if foo.to_s.match(/^\d*$/).nil?
      errors.add(:quantity, "is not a number")
    else
      super
    end
  end
private
  
  def ticketsection_ok
    errors.add(:ticketsection, "does not match ticketrez for show") unless ticketrez.show.ticketsections.include? ticketsection
  end
  
  def performance_ok
    m=ticketrez.show.performancetimes.split("|").map {|p| DateTime.parse(p)}
    errors.add(:performance, "does not exist for this show") unless m.include?(DateTime.parse(performance))
  end
  
  def quantity_ok
    errors.add(:quantity, "is too great") if !quantity.nil? and ticketsection.numavailable(performance.to_s) < quantity
  end
  
end
