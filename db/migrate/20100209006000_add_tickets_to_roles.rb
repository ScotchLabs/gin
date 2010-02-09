class AddTicketsToRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :crudcticketalerts, :boolean
    add_column :roles, :crudrticketalerts, :boolean
    add_column :roles, :cruduticketalerts, :boolean
    add_column :roles, :cruddticketalerts, :boolean
    add_column :roles, :crudcticketrezs, :boolean
    add_column :roles, :crudrticketrezs, :boolean
    add_column :roles, :cruduticketrezs, :boolean
    add_column :roles, :cruddticketrezs, :boolean
    add_column :roles, :crudcticketsections, :boolean
    add_column :roles, :crudrticketsections, :boolean
    add_column :roles, :cruduticketsections, :boolean
    add_column :roles, :cruddticketsections, :boolean
  end

  def self.down
    remove_column :roles, :crudcticketalerts
    remove_column :roles, :crudrticketalerts
    remove_column :roles, :cruduticketalerts
    remove_column :roles, :cruddticketalerts
    remove_column :roles, :crudcticketrezs
    remove_column :roles, :crudrticketrezs
    remove_column :roles, :cruduticketrezs
    remove_column :roles, :cruddticketrezs
    remove_column :roles, :crudcticketsections
    remove_column :roles, :crudrticketsections
    remove_column :roles, :cruduticketsections
    remove_column :roles, :cruddticketsections
  end
end
