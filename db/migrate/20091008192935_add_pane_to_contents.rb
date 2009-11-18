class AddPaneToContents < ActiveRecord::Migration
  def self.up
    add_column :contents, :pane, :string
  end

  def self.down
    remove_column :contents, :pane
  end
end
