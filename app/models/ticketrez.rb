class Ticketrez < ActiveRecord::Base
  belongs_to :show
  
  validates_presence_of :showid, :name, :phone, :sectioninfo, :performance
  validates_inclusion_of :showid, :in => Show.all.map {|show| show.abbrev }
  validates_format_of :email, :with => /[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/, :allow_nil => true, :allow_blank => true
  validates_format_of :phone, :with => /^(1\s*[-\/\.]?)?(\((\d{3})\)|(\d{3}))\s*[-\/\.]?\s*(\d{3})\s*[-\/\.]?\s*(\d{4})\s*(([xX]|[eE][xX][tT])\.?\s*(\d+))*$/
  validate :sectioninfo_ok
  validate :performance_ok
  
private
  def sectioninfo_ok
    # errors.add(:sectioninfo, "message")
    sections = sectioninfo.split("|")
    for section in sections
      sectionname = section.split(":")[0]
      sectionqty = section.split(":")[1]
      puts "DEBUG looking for a ticketsection showid=#{showid}, name=#{sectionname}"
      s = Ticketsection.first(:conditions => ["showid = ? AND name = ?", showid, sectionname])
      errors.add(:sectioninfo, "invalid: section '#{sectionname}' doesn't exist") if s.nil?
      errors.add(:sectioninfo, "invalid: section '#{sectionname}' is full") if !s.nil? && sectionqty.to_i+s.numreserved>s.size
    end
  end
  
  def performance_ok
    s = Show.find_by_abbrev showid
    p=s.performancetimes.split("|").map {|t| Time.parse(t)}
    begin
      DateTime.parse(performance)
    rescue Exception => e
      errors.add(:performance, "can't be parsed")
      return
    end
    errors.add(:performance, "doesn't exist for the show '#{showid}'") if p.index(DateTime.parse(performance)).nil?
  end
end
