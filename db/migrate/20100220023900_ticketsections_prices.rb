class TicketsectionsPrices < ActiveRecord::Migration
  def self.up
    remove_column :ticketsections, :price
    add_column :ticketsections, :pricewithid, :string
    add_column :ticketsections, :pricewoutid, :string
  end
  
  def self.down
    remove_column :ticketsections, :pricewithid
    remove_column :ticketsections, :pricewoutid
    add_column :ticketsections, :price
  end
end