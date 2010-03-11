class FixThings < ActiveRecord::Migration
  def self.up
    Role.destroy_all
    Role.create(:rname => "Administrator", :rabbrev => "admin", :rcontents => "crud", :rshows => "crud", :rusers => "crud", :rupdates => "crud", :rroles => "crud", :rroleassocs => "crud", :rticketalerts => "crud", :rticketrezs => "crud", :rticketsections => "crud", :rrezlineitems => "crud")
    Role.create(:rname => "Developer", :rabbrev => "dev", :rshows => "crud", :rupdates => "crud", :rroles => "crud", :rroleassocs => "crud", :rticketalerts => "crud", :rticketrezs => "crud", :rticketsections => "crud", :rrezlineitems => "crud")
    Role.create(:rname => "Content Writer", :rabbrev => "writer", :rcontents => "crud", :rshows => "crud", :rupdates => "crud", :rticketsections => "crud")
    Role.create(:rname => "Ticketmaster", :rabbrev => "tixer", :rshows => "crud", :rticketalerts => "crud", :rticketrezs => "crud", :rticketsections => "crud", :rrezlineitems => "crud")
    Roleassoc.destroy_all
    Roleassoc.create(:roleid => "admin", :userid => "sewillia")
    Roleassoc.create(:roleid => "dev", :userid => "sewillia")
    Roleassoc.create(:roleid => "dev", :userid => "amgross")
    Roleassoc.create(:roleid => "dev", :userid => "dfreeman")
    Roleassoc.create(:roleid => "dev", :userid => "achivett")
    Roleassoc.create(:roleid => "dev", :userid => "mdickoff")
    Roleassoc.create(:roleid => "writer", :userid => "jrfriedr")
    Roleassoc.create(:roleid => "writer", :userid => "amgross")
    Roleassoc.create(:roleid => "writer", :userid => "tsnider")
    Roleassoc.create(:roleid => "tixer", :userid => "jrfriedr")
    Roleassoc.create(:roleid => "tixer", :userid => "amgross")
    Roleassoc.create(:roleid => "tixer", :userid => "tsnider")
  end

  def self.down
    Role.destroy_all
    Roleassoc.destroy_all
  end
end
