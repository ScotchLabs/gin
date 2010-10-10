class TicketsectionIdRefactor < ActiveRecord::Migration
  def self.up
    # refactor "ticketsection belongs to show"
    add_column :ticketsections, :show_id, :integer
    Ticketsection.all.each do |ts|
      show = Show.find_by_abbrev(ts.showid)
      ts.show_id = show.id unless show.nil?
      ts.save!
    end
    remove_column :ticketsections, :showid
  end

  def self.down
    add_column :ticketsections, :showid
    Ticketsection.all.each do |ts|
      ts.showid = ts.show.abbrev
    end
    remove_column :ticketsections, :show_id
  end
end
