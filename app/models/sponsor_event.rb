class SponsorEvent < ActiveRecord::Base

  validates :month, :presence => true
  validates :day,   :presence => true
  validates :name,  :presence => true

end
