module ShowsHelper
  def format_performance_times(show)
    perfarr = show.performancetimes.split("|")
    dayarr = Array.new
    for perf in perfarr
      t = Time.parse(perf)
      d = Time.local(t.year, t.month, t.day)
      tstr = "#{t.hour}"
      if t.min > 0
        tstr = "#{tstr}:#{t.min.to_s}"
      end
      daypresent = false
      for day in dayarr
        if day[0] == d
          daypresent = true
          break
        end
      end
      if daypresent
        day[1].push(tstr)
      else
        dayarr.push([d,[tstr]])
      end
    end
    out = ""
    for day in dayarr
      out += "<span class='upper'>"
      out += Time.at(day[0]).strftime("%b %d").to_s
      out += "</span>&nbsp;&nbsp;&nbsp;&nbsp;@ "
      for time in day[1]
        if day[1].size() > 2 and day[1].index(time)!=0 and day[1].index(time)<day[1].size()-1
          out += ", "
        elsif day[1].size() > 1 && day[1].index(time)==day[1].size()-1
          out += " & "
        end
        if time.index(":")
          hour = time[0...time.index(":")].to_i
        else
          hour = time.to_i
        end
        milhour = hour
        hour = (hour%12+((time==0)? 12:0))
        out += "#{hour.to_s}#{(time.index ':')? (time[time.index(':')+1..time.length]):('')}#{(milhour>11)? ("p."):("a.")}"
      end
      out += "<br />"
    end
    out
  end
end
