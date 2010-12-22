require 'digest/sha1'

class User < ActiveRecord::Base
  ROLES = 
  [
    ['admin',"Administrator"],
    ['dev',"Developer"],
    ['writer',"Content Writer"],
    ['tixer',"Ticketmaster"]
  ]
  
  attr_accessor :password_confirmation
  attr_accessor :emailConfirmation
  
  before_destroy :cantdeletelast
  
  validates_presence_of   :name, :email
  validates_uniqueness_of :name, :email
  validates_format_of :email, :with => /[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
  validate :email_retyped
  validates_confirmation_of :password
  validates_format_of :roles, :with => /^((admin|dev|tixer|writer)(\|(admin|dev|tixer|writer))*)?$/
  validate :password_not_blank
  validate :password_retyped
  
  def guest?
    name.nil?
  end
  
  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user=nil
      end
    end
    user
  end
  
  def to_s
    name
  end
  
  def self.roles
    ROLES.clone
  end

  def self.with_role(r)
    User.all.select{|u| u.role? r}
  end
  
  def self.role(r)
    User.roles.select{|role| role[0] == r}.first
  end
  
  def role?(r)
    if roles
      roles.split('|').map{|role| role.to_sym}.include? r
    else
      false
    end
  end

  # 'password' is a virtual attribute
  def password
    @password
  end
  
  def retype
    @retype
  end
  
  def emailConfirmation
    @emailConfirmation
  end
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  def cantdeletelast
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
  
private

  def password_not_blank
    errors.add(:password, "Missing password") if hashed_password.blank?
  end
  
  def email_retyped
    errors.add(:email, "doesn't match retyped email address") if email != emailConfirmation
  end
  
  def password_retyped
    if hashed_password.blank? && salt.blank?
      errors.add(:password, "doesn't match the retyped password") if password != retype
    end
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
end
