class AddShowtimesToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :showtimes, :boolean
  end

  def self.down
    remove_column :shows, :showtimes
  end
end
