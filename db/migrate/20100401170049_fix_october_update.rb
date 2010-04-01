class FixOctoberUpdate < ActiveRecord::Migration
  def self.up
    u=Update.find_by_anchor("70ai-oct")
    unless u.nil?
      u.created_at = DateTime.parse("2009-10-01 04:00:00")
      puts u.save
    end
  end

  def self.down
  end
end
