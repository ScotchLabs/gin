require 'net/http'
require 'xml/libxml'

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
  validate :anchor_ok
  validate :article_ok
  validate :templates_ok
  def articletext
    # replace templates
    text = article
    templates = text.scan(/\[\[(a|c|i|m|p){1}\+([0-9a-zA-Z\.\:\/\_\-\~\%\&\#\=\@]+)\|?([0-9a-zA-Z \'\"]*)\]\]/)
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
    	  elsif type == 'i'
    	    html = anchor
    		end
    	else
    		html = temp[2]
    	end
    	if type == 'p' || type == 'c'
    	  out = "<a href='/home/#{action}/#{anchor}'>#{html}</a>"
    	elsif type == 'a'
    	  out = "<a href='#{anchor}' target='_blank'>#{html}</a>"
    	elsif type == 'm'
    	  out = "<a href='mailto://#{anchor}' target='_blank'>#{html}</a>"
    	elsif type == 'i'
    	  out = "<img src='/images/#{anchor}' title='#{html}' alt='#{html}' />"
    	end
    	# replace text in article with out
    	replace = "\[\["+temp[0]+"\+"+temp[1]
    	replace += "\|"+temp[2] if !temp[2].nil? && !temp[2].blank?
    	replace += "\]\]"
    	text = "foo"+text+"bar"
    	text = text.split(replace).join(out)
    	a = text.length-4
    	text = text[3..a]
    end
    text
  end
  
protected
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
  def article_ok
    # make sure they're not using <a> or <img>
    errors.add(:article, "contains <a> tag. Please replace with a template.") if article =~ /\<a\ /
    errors.add(:article, "contains <img> tag. Please replace with a template.") if article =~ /\<img\ /
    # make sure the tags the are using are cool
    parser = XML::Parser.new
    parser.string = "<div>#{article}</div>"
    msgs = []
    XML::Parser.register_error_handler lambda { |msg| msgs << msg }
    begin
      parser.parse
    rescue Exception => e
      htmlvalidout = msgs.join(" ")
      htmlvalidout = htmlvalidout.split(" :").join(" line ")
      errors.add(:article, "contains invalid html. #{htmlvalidout}")
    end
  end
  def templates_ok
    text = article
    templates = text.scan(/\[\[(.+)\]\]/)
    for temp in templates
      # single cases
      next if temp[0]=="board"
      # check for plus sign
      unless temp[0].index('+') == 1
        errors.add(:article, "contains malformed template: no plus sign")
        return
      end
      # check for type
      type = temp[0][0,1]
      unless type =~ /(a|c|i|m|p)/
        errors.add(:article, "contains malformed template: unknown  type")
        return
      end
      # check for anchor
      unless temp[0].length > 2
        errors.add(:article, "contains malformed template: no anchor")
        return
      end
      # check anchor
      if temp[0].index('|') != nil
        b = temp[0].index('|')-1
      else
        b = temp[0].length-1
      end
      anchor = temp[0][2..b]
      unless anchor =~ /[0-9a-zA-Z\.\:\/\_\-\~\%\&\#\=\@]+/
        errors.add(:article, "contains malformed template: anchor contains invalid character")
        return
      end
      if type == 'p'
        p = Pane.find_by_anchor(anchor)
        errors.add(:article, "contains malformed 'p' template: invalid anchor") if p.nil?
        return
      elsif type == 'c'
        c = Content.find_by_anchor(anchor)
        errors.add(:article, "contains malformed 'c' template: invalid anchor") if c.nil?
        return
      elsif type == 'a'
        begin
          uri = URI.parse(anchor)
          if uri.class != URI::HTTP && uri.class != URI::HTTPS
            errors.add(:article, "contains malformed 'a' template: not a valid http address")
            return
          end
        rescue URI::InvalidURIError
          errors.add(:article, "contains malformed 'a' template: invalid format")
          return
        end
      elsif type == 'm'
        unless anchor =~ /([0-9a-zA-Z\.\_\-]+)\@([0-9a-zA-Z\.\_\-]+)\.(net|com|org|me|edu){1}/
          errors.add(:article, "contains malformed 'm' template: invalid email address")
          return
        end
      elsif type == 'i'
        # make sure there's an image that matches anchor
      end
      # check text
      if !temp[0].index('|').nil?
        text = temp[0][temp[0].index('|')..temp[0].length-1]
        unless text =~ /[0-9a-zA-Z \'\"]+/
          errors.add(:article, "contains malformed template: text contains invalid character")
          return
        end
      end
    end
  end
end
