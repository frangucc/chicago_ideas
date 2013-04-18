class SponsorEvent < ActiveRecord::Base

  include SearchSortPaginate

  MONTHS         = %w(January February March April May June July August September October November December)
  MONTH_INTERVAL = %w(Late Mid)
  DAYS           = ('1'..'30').to_a
  VALID_DAYS     = DAYS | MONTH_INTERVAL

  has_many :notes, :as => :asset

  validates :month, :presence => true, :inclusion => { :in => MONTHS,     :message => 'is not a valid month' }
  validates :day,   :presence => true, :inclusion => { :in => VALID_DAYS, :message => 'is not a valid day'   }
  validates :name,  :presence => true

  def self.order_by_month(month)
    select { |se| se.month == month }.sort { |se1, se2| se1.day.to_i <=> se2.day.to_i }
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
