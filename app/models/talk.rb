class Talk < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate
  
  BANNER_WIDTH = 1400
  BANNER_HEIGHT = 390

  belongs_to :track
  belongs_to :day
  belongs_to :venue
  belongs_to :sponsor
  belongs_to :talk_brand
  has_many :chapters
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset

  has_many :talk_photos
  accepts_nested_attributes_for :talk_photos, :allow_destroy => true

  validates :name, :presence => true
  validates :day_id, :presence => true
  validates :venue_id, :presence => true
  validates :talk_brand_id, :presence => true
  validates :start_time, :presence => true
  validates :end_time, :presence => true
  validate :validate_banner_dimensions, :if => "banner.present?", :unless => "errors.any?"
<<<<<<< HEAD
  
  
  # ensure end time is after start time
  before_validation {|record|
    record.errors.add :end_time, "Must be after Start Time." unless record.start_time < record.end_time
  } 
  
  
  def self.random
    if (c = count) != 0
      find(:first, :offset => rand(c))
    end
  end
  
  

  validate :validate_temporal_constraints, :unless => "errors.any?"
    
  # tell the dynamic form that we need to post to an iframe to accept the file upload
  # TODO:: find a more elegant solution to this problem, can we detect the use of has_attached_file?
  def accepts_file_upload?
    true
  end
  
  # large format blessed photo for the website
  has_attached_file :banner,
    :fog_directory => "#{S3_NAMESPACE}-chicago-ideas-talk-banners",
    :path => ":id.:extension"
  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :name => name,
      :description => description,
      :track => track.api_attributes,
      :day => day.api_attributes,
      :venue => venue.api_attributes,
      :start_time => start_time,
      :end_time => end_time,
      :sponsor => sponsor.api_attributes,
      :type => type,
    }
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
  
  # a string representation of the required dimensions for the banner image
  def banner_dimensions_string
    "#{BANNER_WIDTH}x#{BANNER_HEIGHT}"
  end
  
  private 
    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_banner_dimensions
      dimensions = Paperclip::Geometry.from_file(banner.to_file(:original))
      errors.add(:banner, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{banner_dimensions_string}") unless dimensions.width == BANNER_WIDTH && dimensions.height == BANNER_HEIGHT
    end
  
    def validate_temporal_constraints
      # ensure end time is after start time
      errors.add(:end_time, "Must be after Start Time.") unless self.start_time < self.end_time
    end
    
end
