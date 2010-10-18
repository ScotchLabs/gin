class UpdateTixerRoles < ActiveRecord::Migration
  def self.up
    u=User.find_by_name('tixer')
    if u
      u.roles = 'tixer'
      u.emailConfirmation = u.email
      u.save!
    end
  end

  def self.down
  end
end
