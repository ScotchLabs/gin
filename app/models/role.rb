class Role < ActiveRecord::Base
  has_many :roleassocs, :dependent => :destroy
  has_many :users, :through => :roleassocs
  
  def to_s
    rabbrev
  end
end
