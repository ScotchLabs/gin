class RemoveSectioninfoFromTicketrezs < ActiveRecord::Migration
  def self.up
    remove_column :ticketrezs, :sectioninfo
  end

  def self.down
    add_column :ticketrezs, :sectioninfo, :string
  end
end
