class Ticketsection < ActiveRecord::Base
  belongs_to :show
  has_many :ticketrezs
end
