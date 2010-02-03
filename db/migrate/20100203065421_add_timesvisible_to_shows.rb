class AddTimesvisibleToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :timesvisible, :boolean
  end

  def self.down
    remove_column :shows, :timesvisible
  end
end
