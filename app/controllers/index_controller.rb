class IndexController < ApplicationController
  def index
    @updates = Update.not_expired
    @shows = Show.all
    @shows.sort! { |x, y| Time.parse(x.performancetimes.split("|")[0])<=>Time.parse(y.performancetimes.split("|")[0]) }
    @shows.reverse.each { |show| @activeshow = show unless !show.upcoming }
    @contents = Content.all(:order => "contents.order ASC")
  end
  
  def showpane
    @pane = params[:id]
    @contents = Content.all(:conditions => ["contentpane = ?", params[:id]], :order => "contents.order ASC")
  end
  
  def sendemail
    if request.post?
      puts "DEBUG sendemail: post"
    end
    puts "DEBUG sendemail: #{params}" 
  end
  
  #TODO
  #def createticketalert
  #end
  
  #def createticketrez
  #end
protected
  def authorize
  end
end
