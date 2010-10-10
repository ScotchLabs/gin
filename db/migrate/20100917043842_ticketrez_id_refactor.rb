class TicketrezIdRefactor < ActiveRecord::Migration
  def self.up
    # refactor "ticketrez belongs to show"
    add_column :ticketrezs, :show_id, :integer
    Ticketrez.all.each do |tr|
      show = Show.find_by_abbrev(tr.showid)
      tr.show_id = show.id unless show.nil?
      tr.save!
    end
    remove_column :ticketrezs, :showid
  end

  def self.down
    add_column :ticketrezs, :showid
    Ticketrez.all.each do |tr|
      tr.showid = tr.show.abbrev
    end
    remove_column :ticketrezs, :show_id
  end
end
