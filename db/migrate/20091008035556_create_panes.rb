class CreatePanes < ActiveRecord::Migration
  def self.up
    create_table :panes do |t|
      t.string :title
      t.string :menutitle
      t.string :anchor
      t.boolean :publish
      t.boolean :hidden
      t.boolean :hasmenu
      t.integer :order
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :panes
  end
end
