class AddTicketnotesToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :ticketnotes, :text
  end

  def self.down
    remove_column :shows, :ticketnotes
  end
end
