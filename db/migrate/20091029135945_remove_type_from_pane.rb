class RemoveTypeFromPane < ActiveRecord::Migration
  def self.up
    remove_column :panes, :type
  end

  def self.down
    add_column :panes, :type, :string
  end
end
