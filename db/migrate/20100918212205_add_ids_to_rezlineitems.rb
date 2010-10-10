class AddIdsToRezlineitems < ActiveRecord::Migration
  def self.up
    add_column :rezlineitems, :ticketsection_id, :integer
    add_column :rezlineitems, :ticketrez_id, :integer
  end

  def self.down
    remove_column :rezlineitems, :ticketrez_id
    remove_column :rezlineitems, :ticketsection_id
  end
end
