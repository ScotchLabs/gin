require 'digest/sha1'

class Ticketrez < ActiveRecord::Base
  belongs_to :show
  has_many :rezlineitems
  
  attr_accessor :emailconfirm
  
  validates_presence_of :showid, :name, :email
  validates_inclusion_of :showid, :in => Show.all.map {|show| show.abbrev }
  validates_format_of :email, :with => /[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
  validate :salted
  validate :email_retyped
  
  def emailconfirm
    @emailconfirm
  end
  
private
  def email_retyped
    unless email.nil? or email.blank? or emailconfirm.nil? or emailconfirm.blank?
      errors.add(:emailconfirm, "does not match email address") if emailconfirm!=email
    end
  end

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
