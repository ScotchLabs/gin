class Content < ActiveRecord::Base
  CONTENT_TYPES = [
    #displayed    #db
    ["Content", "content"],
    ["Link", "link"]
  ]
  PANES = [
    #displayed  #db
    ["About Us", "about"],
    ["70th Ann. Init.", "70ai"]
  ]
  validates_presence_of :title, :anchor, :contenttype, :contentpane
  validates_numericality_of :order
  validates_inclusion_of :contenttype, :in => CONTENT_TYPES.map {|disp, value| value}
  validates_inclusion_of :contentpane, :in => PANES.map {|disp, val| val}
  validate :anchor_ok
  validate :article_ok

  def articletext
    RedCloth.new(article).to_html
  end
  
protected
  def article_ok
    errors.add(:article, "contains invalid markup") if article.include?("<") || article.include?(">")
  end
  def anchor_ok
    if contenttype != 'link'
      # anchor should be a non-link
      errors.add(:anchor, "is invalid") unless anchor =~ /^[0-9a-zA-Z]+$/
      # make sure it's unique
      c = Content.find_by_anchor(:anchor)
      errors.add(:anchor, "is not unique") unless c.nil?
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
