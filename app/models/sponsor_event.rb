class SponsorEvent < ActiveRecord::Base

  include SearchSortPaginate

  MONTHS         = %w(January February March April May June July August September October November December)
  MONTH_INTERVAL = %w(Late Mid)
  DAYS           = ('1'..'30').to_a
  VALID_DAYS     = DAYS | MONTH_INTERVAL

  belongs_to :year
  has_many :notes, :as => :asset

  validates :month, :presence => true, :inclusion => { :in => MONTHS,     :message => 'is not a valid month' }
  validates :day,   :presence => true, :inclusion => { :in => VALID_DAYS, :message => 'is not a valid day'   }
  validates :name,  :presence => true

  def self.order_by_month(month)
    current_year = Year.current_year
    select { |se| se.year == current_year && se.month == month }.sort { |se1, se2| se1.day.to_i <=> se2.day.to_i }
  end

  def self.upcoming_month
    upcoming_month = nil
    MONTHS.each do |m|
      if SponsorEvent.select { |se| se.month == m }.count > 0
        upcoming_month = m
        break
      end
    end
    upcoming_month
  end

  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    case parent_model.class.name.underscore
    when 'foo'
    else
      [
        { :name => :search, :as => :string, :fields => [:name], :wildcard => :both },
        { :name => :created_at, :as => :datetimerange },
      ]
    end
  end

end
