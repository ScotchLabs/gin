class TicketalertIdRefactor < ActiveRecord::Migration
  def self.up
    # refactor "ticketalert belongs to show"
    add_column :ticketalerts, :show_id, :integer
    Ticketalert.all.each do |ta|
      show = Show.find_by_abbrev(ta.showid)
      ta.show_id = show.id unless show.nil?
      ta.save!
    end
    remove_column :ticketalerts, :showid
  end

  def self.down
    add_column :ticketalerts, :showid
    Ticketalert.all.each do |ta|
      ta.showid = ta.show.abbrev
    end
    remove_column :ticketalerts, :show_id
  end
end
