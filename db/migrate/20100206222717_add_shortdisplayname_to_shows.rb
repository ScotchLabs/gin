class AddShortdisplaynameToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :shortdisplayname, :string
  end

  def self.down
    remove_column :shows, :shortdisplayname
  end
end
