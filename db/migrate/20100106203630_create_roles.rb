class CreateRoles < ActiveRecord::Migration
  def self.up
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
      t.boolean :crudctopics
      t.boolean :crudcposts
      t.boolean :crudccategories
      t.boolean :cruducontents
      t.boolean :crudushows
      t.boolean :crudupanes
      t.boolean :cruduusers
      t.boolean :cruduupdates
      t.boolean :cruduroles
      t.boolean :cruduroleassocs
      t.boolean :crudutopics
      t.boolean :cruduposts
      t.boolean :cruducategories
      t.boolean :cruddcontents
      t.boolean :cruddshows
      t.boolean :cruddpanes
      t.boolean :cruddusers
      t.boolean :cruddupdates
      t.boolean :cruddroles
      t.boolean :cruddroleassocs
      t.boolean :cruddtopics
      t.boolean :cruddposts
      t.boolean :cruddcategories

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
