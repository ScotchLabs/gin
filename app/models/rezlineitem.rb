class Rezlineitem < ActiveRecord::Base
  belongs_to :ticketrez
  belongs_to :ticketsection
  
  validates_presence_of :ticketrez, :message => "does not exist. Please contact a system administrator."
  validates_presence_of :ticketsection, :message => "does not exist. Please contact a system administrator."
  validates_presence_of :performance, :message => "does not exist. Please contact a system administrator."
  validates_presence_of :quantity, :message => "|Please enter a valid quantity."
  validates_numericality_of :quantity, :greater_than => 0, :message => "must be a positive number."
  validate :ticketsection_ok
  validate :performance_ok
  validate :quantity_ok
  
  def quantity=(foo)
    if foo.to_s.match(/^\d*$/).nil?
      errors.add(:quantity, "is not a number.")
    else
      super
    end
  end
private
  
  def ticketsection_ok
    begin
      errors.add(:ticketsection, "does not match ticketrez for show. Please contact a system administrator.") unless ticketrez.show.ticketsections.include? ticketsection
    rescue Exception
      # something went pretty wrong?
    end
  end
  
  def performance_ok
    begin
      m=ticketrez.show.performancetimes.split("|").map {|p| DateTime.parse(p)}
      errors.add(:performance, "does not exist for this show. Please contact a system administrator.") unless m.include?(DateTime.parse(performance))
    rescue Exception
      # something went pretty wrong?
    end
  end
  
  def quantity_ok
    begin
      errors.add(:quantity, "|There aren't that many tickets available for that section and performance.") if !quantity.nil? and ticketsection.numavailable(performance.to_s) < quantity
    rescue Exception
      # something went pretty wrong?
    end
  end
  
end
