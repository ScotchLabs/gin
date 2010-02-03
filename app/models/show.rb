require 'net/http'

class Show < ActiveRecord::Base
  TICKETSTATUS = [
    ["Closed", "closed"],
    ["Open",  "open"],
    ["Completed", "completed"]
  ]
  validates_presence_of :name, :abbrev, :imageurl, :timesvisible, :ticketstatus, :performancetimes
  validates_uniqueness_of :abbrev
  validates_inclusion_of :ticketstatus, :in => TICKETSTATUS.map {|disp, value| value}
  validates_format_of :imageurl, :with => %r{\.(gif|jpg|png)$}i, :message => "must be a URL for GIF, JPG, or PNG image.", :allow_blank => true
  validate :image_exists
  validate :performancetimes_parsable
  
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
    return nil if performancetimes.blank?
    t = performancetimes.split("|")[0]
    t = Time.parse(t)
    t.strftime("%B %Y")
  end
  
  def datecarousel
    return nil if performancetimes.blank?
    t = performancetimes.split("|")[0]
    t = Time.parse(t)
    t.strftime("%B %Y")
  end
  
  def perfcarousel
    return nil if performancetimes.nil?
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
 
  def tickettext
    if ticketstatus == "open"
			"<a href='#'>Reserve my ticket now.</a>"
		elsif ticketstatus == "closed"
			"Tickets are not yet available for reservation (<a href='#'>sign up for an alert</a>)."
		elsif ticketstatus != "completed"
			"<a href='#'>View more about this past Scotch'n'Soda production.</a>"
		end
  end

  def upcoming
    if performancetimes.nil? || performancetimes.blank?
      return true
    else
      return Time.parse(performancetimes.split("|").last)>Time.now
    end
    
  end

private
  def performancetimes_parsable
    return if performancetimes.nil? || performancetimes.blank?
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
