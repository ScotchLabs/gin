class AddShowdatesToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :showdates, :boolean
  end

  def self.down
    remove_column :shows, :showdates
  end
end
