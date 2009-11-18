class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.string :title
      t.string :menutitle
      t.string :anchor
      t.boolean :publish
      t.boolean :hidden
      t.integer :order
      t.text :article

      t.timestamps
    end
  end

  def self.down
    drop_table :contents
  end
end
