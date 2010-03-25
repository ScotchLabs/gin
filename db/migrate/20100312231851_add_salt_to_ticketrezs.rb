class AddSaltToTicketrezs < ActiveRecord::Migration
  def self.up
    add_column :ticketrezs, :salt, :string
  end

  def self.down
    remove_column :ticketrezs, :salt
  end
end
