class Resetpasswords < ActiveRecord::Migration
  def self.up
    User.all.each do |u|
      u.password = 'iamsosecure'
      u.emailConfirmation = u.email
      u.save!
    end
  end

  def self.down
  end
end
