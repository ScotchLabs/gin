class RemoveShownumFromShows < ActiveRecord::Migration
  def self.up
    remove_column :shows, :shownum
  end

  def self.down
    add_column :shows, :shownum, :integer
  end
end
