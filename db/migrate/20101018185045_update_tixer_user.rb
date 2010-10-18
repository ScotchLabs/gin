class UpdateTixerUser < ActiveRecord::Migration
  def self.up
    User.create({:name => 'tixer', :password => 'sellstickets', :email => 'gintixer@snstheatre.org', :emailConfirmation => 'gintixer@snstheatre.org'})
  end

  def self.down
  end
end
