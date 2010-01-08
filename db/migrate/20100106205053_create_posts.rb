class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :topicid
      t.text :article
      t.integer :creatorid
      t.integer :replyto
      t.boolean :deleted

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
