class AddHousemanemailToShows < ActiveRecord::Migration
  def self.up
    add_column :shows, :housemanemail, :string
  end

  def self.down
    remove_column :shows, :housemanemail
  end
end
