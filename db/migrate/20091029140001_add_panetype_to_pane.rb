class AddPanetypeToPane < ActiveRecord::Migration
  def self.up
    add_column :panes, :panetype, :string
  end

  def self.down
    remove_column :panes, :panetype
  end
end
