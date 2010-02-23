class RemoveTicketpricesFromShows < ActiveRecord::Migration
  def self.up
    remove_column :shows, :ticketprices
  end

  def self.down
    add_column :shows, :ticketprices, :string
  end
end
