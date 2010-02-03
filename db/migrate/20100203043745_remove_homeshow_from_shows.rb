class RemoveHomeshowFromShows < ActiveRecord::Migration
  def self.up
    remove_column :shows, :homeshow
  end

  def self.down
    add_column :shows, :homeshow, :string
  end
end
