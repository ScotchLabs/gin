require 'digest/sha1'

class Ticketrez < ActiveRecord::Base
  belongs_to :show
  has_many :rezlineitems
  
  validates_presence_of :showid, :name, :phone
  validates_inclusion_of :showid, :in => Show.all.map {|show| show.abbrev }
  validates_format_of :email, :with => /[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/, :allow_nil => true, :allow_blank => true
  validates_format_of :phone, :with => /^(?:(1)?\s*[-\/\.]?)?(?:\((\d{3})\)|(\d{3}))\s*[-\/\.]?\s*(\d{3})\s*[-\/\.]?\s*(\d{4})\s*(?:(?:[xX]|[eE][xX][tT])\.?\s*(\d+))*$/
  validate :unique_unformattedphone
  
  def name
    @name
  end
  
  def unformattedphone
    regex = /^(?:(1)?\s*[-\/\.]?)?(?:\((\d{3})\)|(\d{3}))\s*[-\/\.]?\s*(\d{3})\s*[-\/\.]?\s*(\d{4})\s*(?:(?:[xX]|[eE][xX][tT])\.?\s*(\d+))*$/
    md = regex.match(phone)
    @unformattedphone = ((md[1].nil?)? "":md[1])+((md[2].nil?)? "":md[2])+((md[3].nil?)? "":md[3])+((md[4].nil?)? "":md[4])+((md[5].nil?)? "":md[5])+((md[6].nil?)? "":md[6])
  end
  
  def name=(n)
    @name=n
    create_new_salt
  end
  
private
  def unique_unformattedphone
    puts "checking if unformattedphone is unique"
    ta=Ticketrez.all(:conditions => ["showid = ?", showid])
    puts "found #{ta.length} ticketrezs to compare to"
    for other in ta
      puts "comparing this '#{self.unformattedphone}' with other '#{other.unformattedphone}'"
      if other.unformattedphone == self.unformattedphone
        errors.add(:reservation, "for this show has already been made") 
      end
    end
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
    self.hashid = Digest::SHA1.hexdigest(self.name+"wibble"+self.salt)
  end
end
