class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :name
      t.integer :categoryid
      t.integer :creatorid
      t.boolean :sticky

      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end