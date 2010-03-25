class RecreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :rname
      t.string :rabbrev
      t.string :rcontents
      t.string :rrezlineitems
      t.string :rroleassocs
      t.string :rroles
      t.string :rshows
      t.string :rticketalerts
      t.string :rticketrezs
      t.string :rticketsections
      t.string :rupdates
      t.string :rusers
    end
  end

  def self.down
    drop_table :roles
  end
end
