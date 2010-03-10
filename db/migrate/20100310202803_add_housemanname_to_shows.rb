class AddHousemannameToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :housemanname, :string
  end

  def self.down
    remove_column :shows, :housemanname
  end
end
