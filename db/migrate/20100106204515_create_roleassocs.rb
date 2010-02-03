class CreateRoleassocs < ActiveRecord::Migration
  def self.up
    create_table :roleassocs do |t|
      t.string :roleid
      t.string :userid

      t.timestamps
    end
  end

  def self.down
    drop_table :roleassocs
  end
end
