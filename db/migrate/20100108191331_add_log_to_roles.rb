class AddLogToRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :crudclogs, :boolean
    add_column :roles, :crudrlogs, :boolean
    add_column :roles, :crudulogs, :boolean
    add_column :roles, :cruddlogs, :boolean
  end

  def self.down
    remove_column :roles, :crudclogs
    remove_column :roles, :crudrlogs
    remove_column :roles, :crudulogs
    remove_column :roles, :cruddlogs
  end
end
