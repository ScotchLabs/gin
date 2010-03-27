class ModeratorModeration < ActiveRecord::Migration
  def self.up
    ["dev","writer","tixer"].each {|abbrev|
      r=Role.find_by_rabbrev(abbrev)
      unless r.nil?
        r.rusers=r.rusers.to_s+'r' if r.rusers.nil? or r.rusers.index('r').nil?
        r.rroles=r.rroles.to_s+'r' if r.rroles.nil? or r.rroles.index('r').nil?
        r.rroleassocs=r.rroleassocs.to_s+'r' if r.rroleassocs.nil? or r.rroleassocs.index('r').nil?
        r.save
      end
    }
  end

  def self.down
  end
end
