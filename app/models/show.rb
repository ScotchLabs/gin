require 'net/http'

class Show < ActiveRecord::Base
  TICKETSTATUS = [
    ["Closed", "closed"],
    ["Open",  "open"],
    ["Completed", "completed"]
  ]
  validates_presence_of :name, :abbrev, :imageurl, :ticketstatus
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
    "datenavigator"
  end
  
  def datecarousel
    "datecarousel"
  end
  
  def perfcarousel
    "perfcarousel"
  end
  
=begin the old way of doing performancedates. I'm keeping it out of nostalgia/NIH
  def carperformances
    showdates = homeshow=="date" || homeshow=="datetime"
    showtimes = homeshow=="datetime"
    return "Performance dates coming soon!<br />" if !showdates
    perfarr = performancetimes.split("|")
    out = ""
    if !showtimes
      dayarr = Array.new
      for perf in perfarr
        t = Time.at(perf.to_i)
        day = Time.local(t.year,t.month,t.day)
        inserted = false
        for range in dayarr
          if range[0].year == day.year && range[0].month == day.month
            if range[0].day == day.day+1
              range[0] = day
              inserted = true
              #out += "updated at beginning: "+day.to_i.to_s+"<br />"
            elsif range[1].day == day.day-1
              range[1] = day
              inserted = true
              #out += "updated at end: "+day.to_i.to_s+"<br />"
            elsif day.day >= range[0].day && day.day <= range[1].day
              #out += "ignored: "+day.to_i.to_s+"<br />"
              inserted = true
            end
          end
        end
        if !inserted
          l = dayarr.length
          dayarr[l] = Array.new(2)
          dayarr[l][0] = day
          dayarr[l][1] = day
          #out += "inserted: "+day.to_i.to_s+"<br />"
        end
      end
      
      # at this point, all performances are distilled into days, and each unique day is inserted into dayarr such that sequential ranges are taken into account
      # to build the final string, keep track of month and year
      range = dayarr[0]
      day = range[0].strftime("%d")
      day = day[1..day.length-1] if day[0]==48
      bing = range[0].strftime("%b ")+day
      if range[0]!=range[1]
        day = range[1].strftime("%d")
        day=day[1..day.length-1] if day[0]==48
        bing += "-"+day
      end
      prevm = range[0].month
      prevy = range[0].year
      montharr = Array.new(1)
      montharr[0] = prevm
      yeararr = Array.new(1)
      yeararr[0] = prevy
      for i in 1...dayarr.length
        range = dayarr[i]
        if yeararr.index(range[0].year).nil?
          bing += ", "+prevy
          yeararr[yeararr.length] = range[0].year
          prevy = range[0].year
        end
        if montharr.index(range[0].month).nil?
          bing += "<br />"+range[0].month
          montharr[montharr.length] = range[0].month
          prevm = range[0].month
        end
        if i == dayarr.length-1
          bing += " & "
        else
          bing += ", "
        end
        bing += range[0].day
        bing += "-"+range[1].day if range[1].day != range[0].day
      end
      bing += ", "+prevy.to_s+"<br />Performance times coming soon!<br />"
      out = bing
    else
      
=begin
      to create times, we first need to separate showtimes by day
      much like did for dayarr, have timearr, first indexes on day,
      second indexes on time
      foreach in first index, print new line with day, then times
 =end

      timesarr = Array.new
      for perf in perfarr
        t = Time.at(perf.to_i)
        day = Time.local(t.year, t.month, t.day)
        insert = timesarr.length
        for i in 0...timesarr.length
          insert = i if timesarr[i][0] == day
        end
        if timesarr[insert].nil?
          timesarr[insert] = Array.new(2)
          timesarr[insert][0] = day
          timesarr[insert][1] = Array.new
        end
        timesarr[insert][1][timesarr[insert][1].length] = perf
      end
        
      # now to debug
      for range in timesarr
        day = range[0].strftime("%d")
        if day[0]==48
          day = day[1..day.length-1]
        end
        out += range[0].strftime("%B ")+day+" at "
        # show first
        hour = Time.at(range[1][0].to_i).strftime("%I")
        if hour[0]==48
          hour = hour[1..hour.length-1]
        end
        out += hour+Time.at(range[1][0].to_i).strftime(" %p")
        # show middle
        for i in 1...range[1].length-2
          hour = Time.at(range[1][i].to_i).strftime("%I")
          if hour[0]==48
            hour = hour[1..hour.length-1]
          end
          out += ", "+hour+Time.at(range[1][i].to_i).strftime(" %p")
        end
        # show last
        if range[1].length > 1
          hour = Time.at(range[1][range[1].length-1].to_i).strftime("%I")
          if hour[0]==48
            hour = hour[1..hour.length-1]
          end
          out += " & "+hour+Time.at(range[1][range[1].length-1].to_i).strftime(" %p")
        end
        out += "<br />"
      end   
    end
    out
  end
  
  def linkperformances
    return if !(homeshow=="date" || homeshow=="datetime")
    perfarr = performancetimes.split("|")
  	perfstart = Time.parse(perfarr[0])
  	perfend = Time.parse(perfarr[perfarr.length-1])
  	performances = perfstart.strftime("%b ") + perfstart.day.to_s
  	performances += ", " + perfstart.year.to_s if perfstart.year != perfend.year
  	performances += " - " if perfstart.to_i != perfend.to_i
  	performances += perfend.strftime("%b ")if perfstart.year != perfend.year || perfstart.month != perfend.month
  	performances += perfend.day.to_s if perfstart.year != perfend.year || perfstart.month != perfend.month || perfstart.day != perfend.day
  	performances += ", " + perfend.year.to_s
  	performances = "" if performancetimes == ""
  	performances
  end
=end
 
  def tickettext
    if ticketstatus == "open"
			"<a href='http://tickets.snstheatre.org/' target='_blank'>#{ticketprices}</a>"
		elsif ticketstatus == "closed"
			"Online reservations coming soon!<br />"
		elsif ticketstatus != "completed"
			"Ticket prices coming soon!"
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
