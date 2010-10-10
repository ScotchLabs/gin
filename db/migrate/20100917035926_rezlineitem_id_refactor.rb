class RezlineitemIdRefactor < ActiveRecord::Migration
  def self.up
    # refactor "rezlineitem belongs to ticketrez"
    #   and "rezlineitem belongs to ticketsection"
    # Rezlineitem.ticketrez_id already exists
    # Rezlineitem.ticketsection_id already exists
    Rezlineitem.all.each do |rli|
      rli.ticketrez_id = rli.rezid if rli.respond_to? "rezid"
      rli.ticketsection_id = rli.sectionid.to_i if rli.respond_to? "sectionid"
      rli.save!
    end
    remove_column :rezlineitems, :rezid
    remove_column :rezlineitems, :sectionid
  end

  def self.down
    add_column :rezlineitems, :rezid, :integer
    add_column :rezlineitems, :sectoinid, :integer
    Rezlineitem.all.each do |rli|
      rli.rezid = rli.ticketrez_id
      rli.sectionid = rli.ticketsection_id
    end
    # Rezlineitem.ticketrez_id already existed
    # Rezlineitem.ticketsection_id already existed
  end
end
