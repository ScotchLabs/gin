class Roleassoc < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  
  validates_presence_of :role, :user
end
