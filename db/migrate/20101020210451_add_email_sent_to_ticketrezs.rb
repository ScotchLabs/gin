class AddEmailSentToTicketrezs < ActiveRecord::Migration
  def self.up
    add_column :ticketrezs, :email_sent, :boolean
  end

  def self.down
    remove_column :ticketrezs, :email_sent
  end
end
