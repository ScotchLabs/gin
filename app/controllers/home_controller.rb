class HomeController < ApplicationController
  def index
    @panes = Pane.find(:all,
                       :conditions => ["hidden = ?", false],
                       :order => "'order' ASC")
    @news = Update.find(:all,
                      :conditions => ["expiredate > ?", DateTime.now],
                      :order => "updated_at DESC")
    @shows = Show.all
    @shows.sort { |x, y| (Time.parse((y.performancetimes.split("|")[0].nil?)? "" : y.performancetimes.split("|")[0])<Time.parse((x.performancetimes.split("|")[0].nil?)? "" : x.performancetimes.split("|")[0]))? -1:1 }
    @shows=@shows.reverse
    @shows.each {|show| 
      @activeshow = show unless !show.upcoming
    }
    @contents = Content.find(:all, :order => "'order' ASC")
  end
  
  def showcontent
    # TODO home/showcontent/blahwrongcontentblah
    @content = Content.find(:first, 
                            :conditions => ["anchor = ?", params[:id]])
    if @content.nil? || !@content.publish
      redirect_to :action => "index"
    end
    @pane = Pane.find(:first,
                      :conditions => ["anchor = ?", @content.contentpane])
    if @pane.nil?
      redirect_to :action => "index"
    end
    @panes = Pane.find(:all, :conditions => ["hidden = ?", false], :order => "'order' ASC")
    @contents = Content.find(:all, :order => "'order' ASC")
  end
  
  def showpane
    # TODO home/showpane/blahwrongpaneblah
    @panes = Pane.all;
    @pane = Pane.find(:first,
                      :conditions => ["anchor = ?", params[:id]]) 
    if @pane.nil? || !@pane.publish
      redirect_to :action => "index"
    end
    @contents = Content.find(:all, :order => "'order' ASC")
  end
protected
  def authorize
  end
end
