class AddDummyUserRoles < ActiveRecord::Migration
  def self.up
    u=User.find_by_name('admin')
    if u
      u.roles = 'admin'
      u.emailConfirmation = u.email
      u.save!
    end
    u=User.find_by_name('dev')
    if u
      u.roles = 'dev'
      u.emailConfirmation = u.email
      u.save!
    end
    u=User.find_by_name('writer')
    if u
      u.roles = 'writer'
      u.emailConfirmation = u.email
      u.save!
    end
  end

  def self.down
  end
end
