require 'digest/sha1'

class Ticketrez < ActiveRecord::Base
  belongs_to :show
  has_many :rezlineitems
  
  validates_presence_of :showid, :name, :email
  validates_inclusion_of :showid, :in => Show.all.map {|show| show.abbrev }
  validates_format_of :email, :with => /[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
  validates_format_of :phone, :with => /^(?:(1)?\s*[-\/\.]?)?(?:\((\d{3})\)|(\d{3}))\s*[-\/\.]?\s*(\d{3})\s*[-\/\.]?\s*(\d{4})\s*(?:(?:[xX]|[eE][xX][tT])\.?\s*(\d+))*$/, :allow_nil => true, :allow_blank => true
  validate :salted
  
private
  def salted
    create_new_salt if self.salt.nil? and !self.name.nil?
    others = Ticketrez.all
    check=true
    while check
      check=false
      for other in others
        if other.hashid==self.hashid
          create_new_salt
          check=true
          break
        end
      end
    end
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
    self.hashid = Digest::SHA1.hexdigest(self.name+"wibble"+self.salt)
  end
end
