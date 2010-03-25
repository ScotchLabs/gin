class FixSlots < ActiveRecord::Migration
  def self.up
    s = Show.find_by_abbrev("drs")
    s.slot = "Carnival"
    s.save
    s = Show.find_by_abbrev("closer")
    s.slot = "Other"
    s.save
    s = Show.find_by_abbrev("betty")
    s.slot = "Other"
    s.save
    s = Show.find_by_abbrev("bttb")
    s.slot = "Other"
    s.save
    s = Show.find_by_abbrev("drood")
    s.slot = "Homecoming"
    s.save
    s = Show.find_by_abbrev("chug")
    s.slot = "Festival"
    s.save
    s = Show.find_by_abbrev("mamg")
    s.slot = "Carnival"
    s.save
    s = Show.find_by_abbrev("afgm")
    s.slot = "Other"
    s.save
    s = Show.find_by_abbrev("abos")
    s.slot = "Other"
    s.save
    s = Show.find_by_abbrev("visit")
    s.slot = "Homecoming"
    s.save
    s = Show.find_by_abbrev("ssu")
    s.slot = "Festival"
    s.save
    s = Show.find_by_abbrev("sotrwat")
    s.slot = "Festival"
    s.save
    s = Show.find_by_abbrev("forum")
    s.slot = "Carnival"
    s.save
    s = Show.find_by_abbrev("proof")
    s.slot = "Other"
    s.save
    s = Show.find_by_abbrev("pillowman")
    s.slot = "Other"
    s.save
    s = Show.find_by_abbrev("cwowsa")
    s.slot = "Homecoming"
    s.save
  end

  def self.down
  end
end
