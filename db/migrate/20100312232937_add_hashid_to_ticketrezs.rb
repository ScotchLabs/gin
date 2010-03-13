class AddHashidToTicketrezs < ActiveRecord::Migration
  def self.up
    add_column :ticketrezs, :hashid, :string
  end

  def self.down
    remove_column :ticketrezs, :hashid
  end
end
