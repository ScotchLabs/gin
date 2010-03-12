class AddSeatingmapToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :seatingmap, :string
  end

  def self.down
    remove_column :shows, :seatingmap
  end
end
