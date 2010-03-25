class AddSlotToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :slot, :string
  end

  def self.down
    remove_column :shows, :slot
  end
end
