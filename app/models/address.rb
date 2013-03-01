class Address < ActiveRecord::Base

  validates :street_1, presence: true
  validates :city, presence: true
  validates :zip, presence: true
  validates :country, presence: true
  validates :state, presence: true

end
