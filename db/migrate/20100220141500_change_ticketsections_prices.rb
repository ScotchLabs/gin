class ChangeTicketsectionsPrices < ActiveRecord::Migration
  def self.up
    remove_column :ticketsections, :pricewithid
    add_column :ticketsections, :pricewithid, :integer
    remove_column :ticketsections, :pricewoutid
    add_column :ticketsections, :pricewoutid, :integer
  end
  
  def self.down
    remove_column :ticketsections, :pricewithid, :integer
    add_column :ticketsections, :pricewithid
    remove_column :ticketsections, :pricewoutid, :integer
    add_column :ticketsections, :pricewoutid
  end
end