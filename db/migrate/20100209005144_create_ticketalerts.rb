class CreateTicketalerts < ActiveRecord::Migration
  def self.up
    create_table :ticketalerts do |t|
      t.string :showid
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :ticketalerts
  end
end
