class RemovePaneFromContent < ActiveRecord::Migration
  def self.up
    remove_column :contents, :pane
  end

  def self.down
    add_column :contents, :pane, :string
  end
end
