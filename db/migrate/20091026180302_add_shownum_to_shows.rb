class AddShownumToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :shownum, :integer
  end

  def self.down
    remove_column :shows, :shownum
  end
end
