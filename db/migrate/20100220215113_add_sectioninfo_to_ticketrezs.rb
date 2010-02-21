class AddSectioninfoToTicketrezs < ActiveRecord::Migration
  def self.up
    add_column :ticketrezs, :sectioninfo, :string
  end

  def self.down
    remove_column :ticketrezs, :sectioninfo
  end
end
