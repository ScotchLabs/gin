class AddHomeshowToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :homeshow, :string
  end

  def self.down
    remove_column :shows, :homeshow
  end
end
