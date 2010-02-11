class Ticketalert < ActiveRecord::Base
  belongs_to :show
  
  validates_presence_of :showid, :email
  # validates format of email
  # validates showid
end
