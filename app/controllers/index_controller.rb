class IndexController < ApplicationController
  def index
    @updates = Array.new
    updates = Update.all(:order => "created_at DESC")
    updates.each {|update| @updates.push(update) unless update.expired }
    @shows = Show.all
    @shows.sort! { |x, y| Time.parse(x.performancetimes.split("|")[0])<=>Time.parse(y.performancetimes.split("|")[0]) }
    @shows.reverse.each { |show| @activeshow = show unless !show.upcoming }
    @contents = Content.all(:order => "contents.order ASC")
  end
  
  def showpane
    @pane = params[:id]
    @contents = Content.all(:conditions => ["contentpane = ?", params[:id]], :order => "contents.order ASC")
  end
protected
  def authorize
  end
end
