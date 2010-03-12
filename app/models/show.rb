require 'net/http'

class Show < ActiveRecord::Base
  has_many :ticketsections
  has_many :ticketrezs
  has_many :ticketalerts
  
  TICKETSTATUS = [["Closed", "closed"],["Open",  "open"],["Completed", "completed"]]
  validates_presence_of :name, :shortdisplayname, :abbrev, :imageurl, :ticketstatus, :performancetimes
  validates_uniqueness_of :abbrev
  validates_length_of :shortdisplayname, :maximum => 30
  validates_inclusion_of :ticketstatus, :in => TICKETSTATUS.map {|disp, value| value}
  validates_format_of :imageurl, :with => %r{\.(gif|jpg|png)$}i, :message => "must be a URL for GIF, JPG, or PNG image.", :allow_blank => true
  validates_format_of :housemanemail, :with => /[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/, :allow_nil => true, :allow_blank => true
  validate :image_exists
  validate :performancetimes_parsable
  
  def ticketsavailable(performance)
    puts "DEBUG show_model#ticketsavailable: checking how many tickets are available for the show '#{abbrev}' for the performance '#{performance}'"
    sections = Ticketsection.all(:conditions => ["showid = ?",abbrev])
    total = 0
    for section in sections
      total += section.numavailable(performance)
    end
    total
  end
  
  def soldout(performance)
    puts "DEBUG show_model#soldout: checking if performance '#{performance}' of show '#{abbrev}' is sold out"
    sections = Ticketsection.all(:conditions => ["showid = ?",abbrev])
    for section in sections
      return false unless section.soldout(performance)
    end
    return true
  end
  
  def sectioninfo
    ticketsections = Ticketsection.all(:conditions => ["showid = ?",abbrev])
    if ticketsections.size == 0
      "This ticket sections for this show have not been set up yet."
    elsif ticketsections.size == 1
      "This show has one general admission section &#8212; $#{ticketsections[0].pricewithid} with a Carnegie Mellon student ID, $#{ticketsections[0].pricewoutid} without."
    else
      r="This show has multiple seating sections:<br />"
      full=true
      for section in ticketsections
        r+="Section "+section.name+" &#8212 $#{section.pricewithid} with "
        r+="a Carnegie Mellon student " and full=false if full
        r+="ID, $#{section.pricewoutid} without"
        r+="<br />"
      end
      r[0..r.length-7]
    end
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
  
  def datecarousel
    t = performancetimes.split("|")[0]
    t = Time.parse(t)
    t.strftime("%B %Y")
  end
  
  def datetickets
    first = DateTime.parse(performancetimes.split("|").first)
    last = DateTime.parse(performancetimes.split("|").last)
    r = first.strftime("")
  end
  
  def perfcarousel
    perfarr = performancetimes.split("|")
    out = ""
    dayarr = Array.new
    for perf in perfarr
      t = Time.parse(perf)
      d = Time.local(t.year, t.month, t.day)
      t = t.hour
      daypresent = false
      for day in dayarr
        if day[0] == d
          daypresent = true
          break
        end
      end
      if daypresent
        day[1].push(t)
      else
        dayarr.push([d,[t]])
      end
    end
    for day in dayarr
      out += "<span class='upper'>";
      out += Time.at(day[0]).strftime("%b %d").to_s
      out += "</span>&nbsp;&nbsp;&nbsp;&nbsp;@ ";
      for time in day[1]
        if day[1].size() > 2 && day[1].index(time)<day[1].size()-2
          out += ", "
        elsif day[1].size() > 1 && day[1].index(time)==day[1].size()-1
          out += " & "
        end
        out += (time%12+((time==0)? 12:0)).to_s+((time>11)? "p.":"a.")
      end
      out += "<br />"
    end
    out
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

  def ticketsections
    Ticketsection.all(:conditions => ["showid = ?",abbrev])
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
end
