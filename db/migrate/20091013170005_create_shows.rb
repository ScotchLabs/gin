class CreateShows < ActiveRecord::Migration
  def self.up
    create_table :shows do |t|
      t.string :name
      t.string :abbrev
      t.string :loc
      t.string :imageurl
      t.string :author
      t.string :ticketprices
      t.string :performancetimes
      t.string :ticketstatus
      t.boolean :scheduled

      t.timestamps
    end
  end

  def self.down
    drop_table :shows
  end
end
