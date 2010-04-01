class SeedUserEmails < ActiveRecord::Migration
  def self.up
    u=User.find_by_name("sewillia")
    u.email="s@spencerenglish.com" unless u.nil?
    u.emailConfirmation="s@spencerenglish.com" unless u.nil?
    puts u.save unless u.nil?
    
    u = User.find_by_name("jrfriedr")
    u.email="jasmine.friedrich@gmail.com" unless u.nil?
    u.emailConfirmation="jasmine.friedrich@gmail.com" unless u.nil?
    puts u.save unless u.nil?
    
    u = User.find_by_name("amgross")
    u.email="amgross@andrew.cmu.edu" unless u.nil?
    u.emailConfirmation="amgross@andrew.cmu.edu" unless u.nil?
    puts u.save unless u.nil?
    
    u = User.find_by_name("dfreeman")
    u.email="dfreeman@andrew.cmu.edu" unless u.nil?
    u.emailConfirmation="dfreeman@andrew.cmu.edu" unless u.nil?
    puts u.save unless u.nil?
    
    u = User.find_by_name("achivett")
    u.email="achivett@andrew.cmu.edu" unless u.nil?
    u.emailConfirmation="achivett@andrew.cmu.edu" unless u.nil?
    puts u.save unless u.nil?
    
    u = User.find_by_name("mdickoff")
    u.email="mdickoff@andrew.cmu.edu" unless u.nil?
    u.emailConfirmation="mdickoff@andrew.cmu.edu" unless u.nil?
    puts u.save unless u.nil?
    
    u = User.find_by_name("tsnider")
    u.email="tsnider@andrew.cmu.edu" unless u.nil?
    u.emailConfirmation="tsnider@andrew.cmu.edu" unless u.nil?
    puts u.save unless u.nil?
  end

  def self.down
  end
end
