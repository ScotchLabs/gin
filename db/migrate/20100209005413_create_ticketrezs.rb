class CreateTicketrezs < ActiveRecord::Migration
  def self.up
    create_table :ticketrezs do |t|
      t.string :showid
      t.string :name
      t.integer :quantity
      t.string :email
      t.integer :sectionid

      t.timestamps
    end
  end

  def self.down
    drop_table :ticketrezs
  end
end
