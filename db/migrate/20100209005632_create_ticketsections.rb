class CreateTicketsections < ActiveRecord::Migration
  def self.up
    create_table :ticketsections do |t|
      t.string :showid
      t.string :name
      t.string :price
      t.integer :size

      t.timestamps
    end
  end

  def self.down
    drop_table :ticketsections
  end
end
