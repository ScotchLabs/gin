class RemoveHiddenFromContents < ActiveRecord::Migration
  def self.up
    remove_column :contents, :hidden
  end

  def self.down
    add_column :contents, :hidden, :boolean
  end
end
