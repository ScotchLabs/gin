class AddDirectorToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :director, :string
  end

  def self.down
    remove_column :shows, :director
  end
end
