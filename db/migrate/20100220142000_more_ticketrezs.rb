class MoreTicketrezs < ActiveRecord::Migration
  def self.up
    add_column :ticketrezs, :phone, :string
    add_column :ticketrezs, :performance, :string
    add_column :ticketrezs, :hasid, :boolean
    remove_column :ticketrezs, :sectionid
    remove_column :ticketrezs, :quantity
  end
  
  def self.down
    remove_column :ticketrezs, :phone
    remove_column :ticketrezs, :performance
    remove_column :ticketrezs, :hasid
    add_column :ticketrezs, :sectionid, :integer
    add_column :ticketrezs, :quantity, :integer
  end
end