class Ticketrez < ActiveRecord::Base
  belongs_to :show
  belongs_to :ticketsection
end
