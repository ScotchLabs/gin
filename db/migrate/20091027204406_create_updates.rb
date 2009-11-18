class CreateUpdates < ActiveRecord::Migration
  def self.up
    create_table :updates do |t|
      t.string :name
      t.string :anchor
      t.datetime :expiredate
      t.text :article

      t.timestamps
    end
  end

  def self.down
    drop_table :updates
  end
end
