class FixSlots < ActiveRecord::Migration
  def self.up
    s = Show.find_by_abbrev("drs")
    s.slot = "Carnival" unless s.nil?
    s.save unless s.nil?
    s = Show.find_by_abbrev("closer")
    s.slot = "Other" unless s.nil?
    s.save unless s.nil?
    s = Show.find_by_abbrev("betty")
    s.slot = "Other" unless s.nil?
    s.save unless s.nil?
    s = Show.find_by_abbrev("bttb")
    s.slot = "Other" unless s.nil?
    s.save unless s.nil?
    s = Show.find_by_abbrev("drood")
    s.slot = "Homecoming" unless s.nil?
    s.save unless s.nil?
    s = Show.find_by_abbrev("chug")
    s.slot = "Festival" unless s.nil?
    s.save unless s.nil?
    s = Show.find_by_abbrev("mamg")
    s.slot = "Carnival" unless s.nil?
    s.save unless s.nil?
    s = Show.find_by_abbrev("afgm")
    s.slot = "Other" unless s.nil?
    s.save unless s.nil?
    s = Show.find_by_abbrev("abos")
    s.slot = "Other" unless s.nil?
    s.save unless s.nil?
    s = Show.find_by_abbrev("visit")
    s.slot = "Homecoming" unless s.nil?
    s.save unless s.nil?
    s = Show.find_by_abbrev("ssu")
    s.slot = "Festival" unless s.nil?
    s.save unless s.nil?
    s = Show.find_by_abbrev("sotrwat")
    s.slot = "Festival" unless s.nil?
    s.save unless s.nil?
    s = Show.find_by_abbrev("forum")
    s.slot = "Carnival" unless s.nil?
    s.save unless s.nil?
    s = Show.find_by_abbrev("proof")
    s.slot = "Other" unless s.nil?
    s.save unless s.nil?
    s = Show.find_by_abbrev("pillowman")
    s.slot = "Other" unless s.nil?
    s.save unless s.nil?
    s = Show.find_by_abbrev("cwowsa")
    s.slot = "Homecoming" unless s.nil?
    s.save unless s.nil?
  end

  def self.down
  end
end
