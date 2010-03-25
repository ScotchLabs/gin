class CreateRezlineitems < ActiveRecord::Migration
  def self.up
    create_table :rezlineitems do |t|
      t.integer :rezid
      t.string :performance
      t.string :sectionid
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :rezlineitems
  end
end
