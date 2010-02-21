class Ticketrez < ActiveRecord::Base
  belongs_to :show
  belongs_to :ticketsection
  
  validates_presence_of :showid, :name, :phone, :email, :sectioninfo
  validates_inclusion_of :showid, :in => Show.all.map {|show| show.abbrev }
  # validates phone
  # validates sectioninfo
  # validates performance
  # validates_format_of email blank=true
  # validates sectioninfo
end
