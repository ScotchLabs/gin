class HomeController < ApplicationController
  def index
    @panes = Pane.all(:conditions => ["hidden = ?", false], :order => "panes.order ASC")
    @news = Update.all(:conditions => ["expiredate > ?", DateTime.now], :order => "updated_at DESC")
    @shows = Show.all
    @shows.sort { |x, y| (Time.parse((y.performancetimes.split("|")[0].nil?)? "" : y.performancetimes.split("|")[0])<Time.parse((x.performancetimes.split("|")[0].nil?)? "" : x.performancetimes.split("|")[0]))? -1:1 }
    @shows=@shows.reverse
    @shows.each { |show| @activeshow = show unless !show.upcoming }
    @contents = Content.find(:all, :order => "contents.order ASC")
  end
  
  def showcontent
    @content = Content.find(:first, :conditions => ["anchor = ?", params[:id]])
    redirect_to :action => "index" if @content.nil? || !@content.publish
    @pane = Pane.find(:first, :conditions => ["anchor = ?", @content.contentpane])
    redirect_to :action => "index" if @pane.nil? || !@pane.publish
    @panes = Pane.all(:conditions => ["hidden = ?", false], :order => "panes.order ASC")
    @contents = Content.find(:all, :order => "contents.order ASC")
  end
  
  def showpane
    @panes = Pane.all(:conditions => ["hidden = ?", false], :order => "panes.order ASC")
    @pane = Pane.find(:first, :conditions => ["anchor = ?", params[:id]]) 
    redirect_to :action => "index" if @pane.nil? || !@pane.publish
    @contents = Content.find(:all, :order => "contents.order ASC")
  end
protected
  def authorize
  end
end
