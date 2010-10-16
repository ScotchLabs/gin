require 'digest/sha1'

class Ticketrez < ActiveRecord::Base
  belongs_to :show
  has_many :rezlineitems, :dependent => :destroy
  
  attr_accessor :emailconfirm
  
  validates_presence_of :show, :message => "id is invalid. Please contact the system administrator."
  validates_presence_of :hasid, :message => "|Please indicate if you have a CMU ID."
  validates_presence_of :name, :message => "|Please enter your name."
  validates_presence_of :email, :message => "|Please enter a valid email address."
  validates_format_of :email, :with => /[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/, :message => "address appears to be an invalid format."
  validate :salted
  validate :email_retyped
  
  def emailconfirm
    @emailconfirm
  end
  
private
  def email_retyped
    unless email.nil? or email.blank? or emailconfirm.nil? or emailconfirm.blank?
      errors.add(:email,"addresses do not match.") if emailconfirm!=email
    end
  end

  def salted
    create_new_salt if self.salt.nil? and !self.name.nil?
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
    self.hashid = Digest::SHA1.hexdigest(self.name+"wibble"+self.salt)
  end
end
