class HomeController < ApplicationController
  def index
    @panes = Pane.all(:order => "panes.order ASC")
    @news = Update.all(:conditions => ["expiredate > ?", DateTime.now], :order => "updated_at DESC")
    @shows = Show.all
    @shows.sort { |x, y| (Time.parse((y.performancetimes.split("|")[0].nil?)? "" : y.performancetimes.split("|")[0])<Time.parse((x.performancetimes.split("|")[0].nil?)? "" : x.performancetimes.split("|")[0]))? -1:1 }
    @shows=@shows.reverse
    @shows.each { |show| @activeshow = show unless !show.upcoming }
    @contents = Content.all(:order => "contents.order ASC")
  end
  
  def showcontent
    @content = Content.find(:first, :conditions => ["anchor = ?", params[:id]])
    redirect_to :action => "index" if @content.nil? || (!@content.publish && session[:display_mode] != "full")
    @pane = Pane.find(:first, :conditions => ["anchor = ?", @content.contentpane])
    redirect_to :action => "index" if @pane.nil? || (!@pane.publish && session[:display_mode] != "full")
    @panes = Pane.all(:order => "panes.order ASC")
    @contents = Content.find(:all, :order => "contents.order ASC")
  end
  
  def showpane
    @panes = Pane.all(:order => "panes.order ASC")
    @pane = Pane.find(:first, :conditions => ["anchor = ?", params[:id]]) 
    redirect_to :action => "index" if @pane.nil? || (!@pane.publish && session[:display_mode] != "full")
    @contents = Content.find(:all, :order => "contents.order ASC")
  end
protected
  def authorize
  end
end
