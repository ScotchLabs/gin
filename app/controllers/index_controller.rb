class IndexController < ApplicationController
  def index
    @updates = Update.all(:conditions => ["expiredate > ?", DateTime.now], :order => "updated_at DESC")
    @shows = Show.all
    @shows.sort! { |x, y| Time.parse(x.performancetimes.split("|")[0])<=>Time.parse(y.performancetimes.split("|")[0]) }
    @shows.reverse.each { |show| @activeshow = show unless !show.upcoming }
    @contents = Content.all(:order => "contents.order ASC")
  end
  
  def showcontent
    @content = Content.find(:first, :conditions => ["anchor = ?", params[:id]])
    redirect_to :action => "index" if @content.nil? || (!@content.publish && session[:display_mode] != "full")
    @contents = Content.find(:all, :order => "contents.order ASC")
  end
  
  def showpane
    @pane = params[:id]
    @contents = Content.find(:all, :order => "contents.order ASC")
  end
protected
  def authorize
  end
end
