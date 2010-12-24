require 'net/http'

class Show < ActiveRecord::Base
  has_many :ticketsections, :dependent => :destroy
  has_many :ticketrezs, :dependent => :destroy
  has_many :ticketalerts, :dependent => :destroy
  
  TICKETSTATUS = [["Closed", "closed"],["Open",  "open"],["Completed", "completed"]]
  validates_presence_of :name, :shortdisplayname, :abbrev, :imageurl, :ticketstatus, :performancetimes, :slot
  validates_uniqueness_of :abbrev
  validates_length_of :shortdisplayname, :maximum => 30
  validates_inclusion_of :ticketstatus, :in => TICKETSTATUS.map {|disp, value| value}
  validates_inclusion_of :slot, :in => ["Other","Homecoming","Carnival","Festival"]
  validates_format_of :imageurl, :with => %r{\.(gif|jpg|png)$}i, :message => "must be a URL for GIF, JPG, or PNG image.", :allow_blank => true
  validates_format_of :seatingmap, :with => %r{\.(gif|jpg|png)$}i, :message => "must be a URL for GIF, JPG, or PNG image.", :allow_blank => true
  validates_format_of :housemanemail, :with => /[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/, :allow_nil => true, :allow_blank => true
  validate :image_exists
  validate :seatingmap_exists
  validate :performancetimes_parsable
  
  def to_s
    name
  end
    
  def soldout(performance)
    for section in ticketsections
      return false unless section.soldout(performance)
    end
    return true
  end
  
  def displayname
    if name.length() > 30
      shortdisplayname
    else
      name
    end
  end
  
  def inseason
    now = Time.new
    if now.month.to_i > 6
      seasonstart = Time.utc(now.year,7,1,0,0,0).to_i.to_s
      seasonend = Time.utc(now.year+1,6,30,23,59,59).to_i.to_s
    else
      seasonstart = Time.utc(now.year-1,7,1,0,0,0).to_i.to_s
      seasonend = Time.utc(now.year,6,30,23,59,59).to_i.to_s
    end
    return ticketstatus == "closed" || ticketstatus == "open" || (!performancetimes.nil? && !performancetimes.blank? && performancetimes < seasonend && performancetimes > seasonstart)
  end
  
  def datenavigator
    t = performancetimes.split("|")[0]
    t = Time.parse(t)
    t.strftime("%B %Y")
  end
 
  def upcoming
    Time.parse(performancetimes.split("|").last)>Time.now
  end
  
  def performances
    timearr = Array.new
    perfarr = performancetimes.split("|")
    perfarr.each { |perf| timearr.push(Time.parse(perf).strftime("%B %d - %I:%M %p")) }
    timearr
  end

private
  def performancetimes_parsable
    perfarr = performancetimes.split("|")
    for perf in perfarr
      begin
        DateTime.parse(perf)
      rescue Exception => e
        errors.add(:performancetimes, "contains a non-parsable date: "+perf)
      end
    end
  end
  def image_exists
      Net::HTTP.start("upload.snstheatre.org") { |http|
        resp = http.get("/gin/shows/#{imageurl}")
        errors.add(:imageurl, "points to an invalid location") if resp.body.to_s =~ /404\ Not\ Found/
      }
  end
  def seatingmap_exists
    if !seatingmap.blank? && !seatingmap.nil?
      Net::HTTP.start("upload.snstheatre.org") { |http|
        resp = http.get("/gin/shows/seatingmaps/#{seatingmap}")
        errors.add(:seatingmap, "points to an invalid location") if resp.body.to_s =~ /404\ Not\ Found/
      }
    end
  end
end
