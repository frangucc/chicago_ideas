class SponsorEvent < ActiveRecord::Base

  include SearchSortPaginate

  has_many :notes, :as => :asset

  validates :month, :presence => true
  validates :day,   :presence => true
  validates :name,  :presence => true

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
