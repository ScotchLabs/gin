class RemovePhoneFromTicketrez < ActiveRecord::Migration
  def self.up
    remove_column :ticketrezs, :phone
  end

  def self.down
    add_column :ticketrezs, :phone, :string
  end
end
