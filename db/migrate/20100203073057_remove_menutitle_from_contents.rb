class RemoveMenutitleFromContents < ActiveRecord::Migration
  def self.up
    remove_column :contents, :menutitle
  end

  def self.down
    add_column :contents, :menutitle, :string
  end
end
