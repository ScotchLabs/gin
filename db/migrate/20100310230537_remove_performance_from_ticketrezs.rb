class RemovePerformanceFromTicketrezs < ActiveRecord::Migration
  def self.up
    remove_column :ticketrezs, :performance
  end

  def self.down
    add_column :ticketrezs, :performance, :string
  end
end
