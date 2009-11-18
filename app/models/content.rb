require 'net/http'
class Content < ActiveRecord::Base
  CONTENT_TYPES = [
    #displayed    #db
    ["Content", "content"],
    ["Link", "link"]
  ]
  belongs_to :pane
  validates_presence_of :title, :anchor
  validates_numericality_of :order
  validates_inclusion_of :contenttype, :in => CONTENT_TYPES.map {|disp, value| value}
  validate :templates_ok
  validate :anchor_ok
  def articletext
    # replace templates
    text = article
    templates = text.scan(/\[\[(a|p|c)\+([A-Za-z0-9\-\.\/\@]+)\|?([A-Za-z0-9\-]+)?\]\]/)
    for temp in templates
    	# turn scan result into link_to
    	type = temp[0]
    	anchor = temp[1]
    	if temp[2].nil? || temp[2].blank?
    		if type == 'p'
    			p = Pane.find_by_anchor(anchor)
    			html = p.title
    			action = "showpane"
    		elsif type == 'c'
    			c = Content.find_by_anchor(anchor)
    			html = c.title
    			action = "showcontent"
    		elsif type == 'a'
    		  html = anchor
    		elsif type == 'm'
    	    html = anchor
    		#elsif type == 'i'
    		#  html = anchor
    		end
    	else
    	  # special/html is specified
    	  # special case for i
    		html = temp[2]
    	end
    	if type == 'p' || type == 'c'
    	  out = "<a href='/home/#{action}/#{anchor}'>#{html}</a>"
    	elsif type == 'a'
    	  if (anchor[0,7] == "http://")
    	    anchor = anchor[7,anchor.length]
    	  end
    	  out = "<a href='#{anchor}'>#{html}</a>"
    	elsif type == 'm'
    	  out = "<a href='mailto://#{anchor}'>#{html}</a>"
    	elsif type == 'i'
    	  # image_tag?
    	  # out = ""
    	end
    	# replace text in article with out
    	replace = "\[\["+temp[0]+"\+"+temp[1]
    	if !temp[2].nil? && !temp[2].blank?
    		replace += "\|"+temp[2]
    	end
    	replace += "\]\]"
    	text = "foo"+text+"bar"
    	text = text.split(replace).join(out)
    	a = text.length-4
    	text = text[3..a]
    end
    # now do the one-time templates ([[board]] etc)
    text
  end
protected
  def anchor_ok
    if contenttype != 'link'
      # anchor should be a non-link
      errors.add(:anchor, "is invalid") unless :anchor =~ /^A[0-9a-zA-Z]+^Z/
      # make sure it's unique
      c = Content.find_by_anchor(:anchor)
      errors.add(:anchor, "is not unique") unless c.nil?
    end
    begin
      uri = URI.parse(anchor)
      if uri.class != URI::HTTP
        errors.add(:anchor, "is not an http address")
      end
    rescue URI::InvalidURIError
      errors.add(:anchor, "has an invalid format")
    end
  end
  def templates_ok
    text = article
    templates = text.scan(/\[\[(.+)\]\]/)
    for temp in templates
      # check for plus sign
      unless temp[0].index('+') == 1
        errors.add(:article, "contains malformed template (no plus sign)")
        return
      end
      # check for type
      type = temp[0][0,1]
      unless type =~ /(a|m|p|c)/
        errors.add(:article, "contains malformed template (doesn't begin with a, c, m or p)")
        return
      end
      # check for anchor
      unless temp[0].length > 2
        errors.add(:article, "contains malformed template (no anchor)")
        return
      end
      # check anchor
      if temp[0].index('|') != nil
        b = temp[0].index('|')-1
      else
        b = temp[0].length-1
      end
      first = temp[0][2..b]
      if type == 'p'
        p = Pane.find_by_anchor(first)
        errors.add(:article, "contains malformed 'p' template (invalid anchor)") if p.nil?
        return
      elsif type == 'c'
        c = Content.find_by_anchor(first)
        errors.add(:article, "contains malformed 'c' template (invalid anchor)") if c.nil?
        return
      elsif type == 'a'
        begin
          uri = URI.parse(first)
          if uri.class != URI::HTTP
            errors.add(:article, "contains malformed 'a' template (not a valid http address)")
          end
        rescue URI::InvalidURIError
          errors.add(:article, "contains malformed 'a' template (invalid format)")
        end
      elsif type == 'm'
        errors.add(:article, "contains 'm' template, which I haven't implemented yet...")
      end
    end
  end
end
