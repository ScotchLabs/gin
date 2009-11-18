class RemoveScheduledFromShows < ActiveRecord::Migration
  def self.up
    remove_column :shows, :scheduled
  end

  def self.down
    add_column :shows, :scheduled, :boolean
  end
end
