class AddContentpaneToContent < ActiveRecord::Migration
  def self.up
    add_column :contents, :contentpane, :string
  end

  def self.down
    remove_column :contents, :contentpane
  end
end
