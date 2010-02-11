class Ticketrez < ActiveRecord::Base
  belongs_to :show
  belongs_to :ticketsection
  
  validates_presence_of :showid, :name, :quantity, :email, :sectionid
  # validates showid
  # validates name
  # validates_format_of :quantity
  # validates_format_of email
  # validates sectionid
end
