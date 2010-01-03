class AddContenttypeToContents < ActiveRecord::Migration
  def self.up
    add_column :contents, :contenttype, :string
  end

  def self.down
    remove_column :contents, :contenttype
  end
end
