class Pane < ActiveRecord::Base
  PANE_TYPES = [
    # Displayed         stored in db
    [ "Content Pane",   "pane" ],
    [ "Link out",       "link" ]
  ]
  has_many :contents
  validates_presence_of :title, :anchor, :panetype
  validates_numericality_of :order
  validates_inclusion_of :panetype, :in => PANE_TYPES.map {|disp, value| value}
  validate :anchor_ok
# validate :url_ok

  def menulabel
    menulabel = title
    if !menutitle.nil? && !menutitle.blank?
    	menulabel = menutitle
    end
    menulabel = menulabel.split(" ").join("&nbsp;")
  end
  def link
    if panetype == "link"
    	link = ""+anchor
    else
    	link = {:controller => "index", :action => "showpane", :id => anchor}
    end
  end
protected
  def anchor_ok
    if panetype != 'link'
      # anchor should be a non-link
      errors.add(:anchor, "contains an invalid character") unless anchor =~ /^[0-9a-zA-Z]+$/
      # make sure it's unique
      p = Pane.find_by_anchor(anchor)
      errors.add(:anchor, "is not unique") unless p.nil?
    else
      begin
        uri = URI.parse(anchor)
        if uri.class != URI::HTTP
          errors.add(:anchor, "is not an http address")
        end
      rescue URI::InvalidURIError
        errors.add(:anchor, "has an invalid format")
      end
    end
  end
end
