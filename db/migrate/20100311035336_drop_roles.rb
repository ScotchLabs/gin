class DropRoles < ActiveRecord::Migration
  def self.up
    drop_table :roles
  end

  def self.down
    create_table :roles do |t|
        t.string :name
        t.string :abbrev
        t.boolean :crudccontents
        t.boolean :crudcshows
        t.boolean :crudcpanes
        t.boolean :crudcusers
        t.boolean :crudcupdates
        t.boolean :crudcroles
        t.boolean :crudcroleassocs
        t.boolean :crudrcontents
        t.boolean :crudrshows
        t.boolean :crudrpanes
        t.boolean :crudrusers
        t.boolean :crudrupdates
        t.boolean :crudrroles
        t.boolean :crudrroleassocs
        t.boolean :cruducontents
        t.boolean :crudushows
        t.boolean :crudupanes
        t.boolean :cruduusers
        t.boolean :cruduupdates
        t.boolean :cruduroles
        t.boolean :cruduroleassocs
        t.boolean :cruddcontents
        t.boolean :cruddshows
        t.boolean :cruddpanes
        t.boolean :cruddusers
        t.boolean :cruddupdates
        t.boolean :cruddroles
        t.boolean :cruddroleassocs
        t.boolean :crudcticketalerts
        t.boolean :crudrticketalerts
        t.boolean :cruduticketalerts
        t.boolean :cruddticketalerts
        t.boolean :crudcticketrezs
        t.boolean :crudrticketrezs
        t.boolean :cruduticketrezs
        t.boolean :cruddticketrezs
        t.boolean :crudcticketsections
        t.boolean :crudrticketsections
        t.boolean :cruduticketsections
        t.boolean :cruddticketsections
  
        t.timestamps
      end
  end
end
