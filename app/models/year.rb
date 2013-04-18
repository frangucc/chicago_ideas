class Year < ActiveRecord::Base

  has_many :days
  has_many :speakers, :dependent => :destroy
  has_many :users, :through => :speakers
  has_many :member_types
  has_many :members
  has_many :sponsor_events

  # Get all years that are not this year - for archived talks
  scope :not_this_year, where("id != #{Time.now.year}")

  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.underscore.downcase,
      :days => days.present? ? days.collect { |day| day.api_attributes } : []
    }
  end

  def self.current_year
    self.find_by_id(Time.current.year)
  end

  def self.current_year_member_types
    current_year.member_types
  end

  def self.current_year_members
    current_year.members
  end

  def self.total_orders_by_member_type_in_current_year
    current_year.member_types.joins(:orders).group(:member_type_id).count
  end

  def self.total_amount_orders_by_member_type_in_current_year
    current_year.member_types.joins(:orders).group(:member_type_id).sum(:total_in_cents)
  end

end
