class CreateDummyUsers < ActiveRecord::Migration
  def self.up
    User.create({:name => 'dev', :hashed_password => '5e180edcb37891fe4e6cfed2cc2d91b692d47c07', :salt => '21733832800.240793202981566', :email => 'gindev@snstheatre.org', :emailConfirmation => 'gindev@snstheatre.org'})
    User.create({:name => 'admin', :hashed_password => '5e180edcb37891fe4e6cfed2cc2d91b692d47c07', :salt => '21733832800.240793202981566', :email => 'ginadmin@snstheatre.org', :emailConfirmation => 'ginadmin@snstheatre.org'})
    User.create({:name => 'writer', :hashed_password => '5e180edcb37891fe4e6cfed2cc2d91b692d47c07', :salt => '21733832800.240793202981566', :email => 'ginwriter@snstheatre.org', :emailConfirmation => 'ginwriter@snstheatre.org'})
    User.create({:name => 'tixer', :hashed_password => '5e180edcb37891fe4e6cfed2cc2d91b692d47c07', :salt => '21733832800.240793202981566', :email => 'gintixer@snsteheatre.org', :emailConfirmation => 'gintixer@snstheatre.org'})
  end

  def self.down
  end
end
