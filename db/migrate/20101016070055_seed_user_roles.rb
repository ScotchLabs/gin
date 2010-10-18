class SeedUserRoles < ActiveRecord::Migration
  def self.up
    u = User.find_by_name('sewillia')
    if u
      u.roles = 'admin'
      u.emailConfirmation = u.email
      u.save!
    end
    u = User.find_by_name('jrfriedr')
    if u
      u.roles = 'writer|tixer'
      u.emailConfirmation = u.email
      u.save!
    end
    u = User.find_by_name('dfreeman')
    if u
      u.roles = 'dev'
      u.emailConfirmation = u.email
      u.save!
    end
    u = User.find_by_name('achivett')
    if u
      u.roles = 'admin'
      u.emailConfirmation = u.email
      u.save!
    end
    u = User.find_by_name('amgross')
    if u
      u.roles = 'dev'
      u.emailConfirmation = u.email
      u.save!
    end
    u = User.find_by_name('mdickoff')
    if u
      u.roles = 'dev'
      u.emailConfirmation = u.email
      u.save!
    end
  end

  def self.down
  end
end
