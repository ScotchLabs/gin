class AddCanceledToTicketrezs < ActiveRecord::Migration
  def self.up
    add_column :ticketrezs, :canceled, :boolean
  end

  def self.down
    remove_column :ticketrezs, :canceled
  end
end
