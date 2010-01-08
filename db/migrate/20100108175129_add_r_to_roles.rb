class AddRToRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :crudrcontents, :boolean
    add_column :roles, :crudrpanes, :boolean
    add_column :roles, :crudrshows, :boolean
    add_column :roles, :crudrupdates, :boolean
    add_column :roles, :crudrusers, :boolean
    add_column :roles, :crudrroles, :boolean
    add_column :roles, :crudrroleassocs, :boolean
    add_column :roles, :crudrcategories, :boolean
    add_column :roles, :crudrtopics, :boolean
    add_column :roles, :crudrposts, :boolean
  end

  def self.down
    remove_column :roles, :crudrcontents
    remove_column :roles, :crudrpanes
    remove_column :roles, :crudrshows
    remove_column :roles, :crudrupdates
    remove_column :roles, :crudrusers
    remove_column :roles, :crudrroles
    remove_column :roles, :crudrroleassocs
    remove_column :roles, :crudrcategories
    remove_column :roles, :crudrtopics
    remove_column :roles, :crudrposts
  end
end
