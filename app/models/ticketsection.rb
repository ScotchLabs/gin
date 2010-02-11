class Ticketsection < ActiveRecord::Base
  belongs_to :show
  has_many :ticketrezs
  
  validates_presence_of :showid, :price, :size, :name
  # validates showid
  validates_numericality_of :price, :size
end
