class Update < ActiveRecord::Base
  validates_presence_of :name, :anchor, :expiredate
  validates_uniqueness_of :anchor
  # validate expiredate is in the future
  validate :expiredate_in_future
  validate :templates_ok
  def articletext
    # replace templates
    text = article
    templates = text.scan(/\[\[(a|p|c)\+([A-Za-z0-9-]+)\|?([A-Za-z0-9-]+)?\]\]/)
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
    		  html = a
    		end
    	else
    		html = temp[2]
    	end
    	if type == 'p' || type == 'c'
    	  out = "<a href='/home/#{action}/#{anchor}'>#{html}</a>"
    	elsif type == 'a'
    	  out = "<a href='#{anchor}'>#{html}</a>"
    	end
  #  	out = link_to html, {:controller => "home", :action => action, :id => anchor}
    	# replace text in article with link_to
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
  def expiredate_in_future
    errors.add(:expiredate, "not in the future.") if Time.parse(expiredate.to_s).to_i <= Time.now.utc.to_i
  end
end
