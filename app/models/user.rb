class User < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate
  # chainable arel method and a boolean helper to determine if models are deleted or not
  include DeleteByTime

  PORTRAIT1_WIDTH = 468
  PORTRAIT1_HEIGHT = 468

  PORTRAIT2_WIDTH = 680
  PORTRAIT2_HEIGHT = 400

  # we have a polymorphic relationship with notes
  has_many :speakers, :dependent => :destroy
  has_many :years, :through => :speakers
  has_many :notes, :as => :asset
  has_many :performances, :foreign_key => :speaker_id
  has_many :chapters, :through => :performances

  has_many :event_speakers, :foreign_key => :speaker_id
  has_many :events, :through => :event_speakers
  has_many :quotes


  has_one :volunteer, :dependent => :destroy
  has_one :community_partner_application
  has_one :affiliate_event_application
  has_one :bhsi_application
  has_one :sponsor_user, :dependent => :destroy
  has_one :sponsor, through: :sponsor_user
  has_one :simulate_user
  has_one :member, :autosave => true
  has_one :demographic_info
  has_many :orders

  belongs_to :address, :autosave => true

  accepts_nested_attributes_for :quotes, :allow_destroy => true
  accepts_nested_attributes_for :sponsor_user, :allow_destroy => true

  delegate :street_1, :city, :state, :zip, :phone, :to => :address, :allow_nil => true

  # useful scopes
  scope :admin,     conditions: { admin:        true }
  scope :speaker,   conditions: { is_speaker:   true }
  scope :volunteer, conditions: { is_volunteer: true }
  scope :staff,     conditions: { staff:        true }
  scope :member,    conditions: { is_member:    true }

  scope :current,  joins(:years).where("years.id = #{DateTime.now.year}")
  scope :archived, joins(:years).where("years.id != #{DateTime.now.year}")

  scope :by_name, order('name asc')

  # Search Indexing
  define_index do
    where "speaker = 1 OR staff = 1 AND deleted_at IS NOT NULL"
    indexes name
    indexes bio
    has created_at, updated_at
  end

  # if a temporary_password is provided, a random password will be generated
  # this random password will be sent to the welcome email, so we can notify the user of it
  attr_accessor :temporary_password

  attr_accessor :is_admin_created, :role, :creation_password

  # devise modules
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :invitable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :title,
                  :bio, :twitter_screen_name, :newsletter, :portrait, :portrait2,
                  :quotes_attributes, :year_ids, :role, :sponsor_user_attributes, :staff, :is_sponsor
  HINT={admin: "Super Admins access full admin and can simulate other admin users.",
        sponsor: "Sponsor Admins can access their respective sponsor portals.",
        speaker: "Speakers can access Speaker portal and be associated with talks.",
        volunteer: "Volunteers can access Speaker portal.",
        member: "Members can access Member portal."}
  ROLES={"Super Admin<br><div class='hint'>#{HINT[:admin]}</span>".html_safe => "admin",
         "Sponsor Admin<br><div class='hint'>#{HINT[:sponsor]}</span>".html_safe => "is_sponsor",
         "Speaker<br><div class='hint'>#{HINT[:speaker]}</span>".html_safe => "is_speaker",
         "Volunteer<br><div class='hint'>#{HINT[:volunteer]}</span>".html_safe => "is_volunteer",
         "Member<br><div class='hint'>#{HINT[:member]}</span>".html_safe => "is_member"}
  # validators
  validates :email, :email => true, :presence => true, :uniqueness => true
  validates :name, :presence => true

  # welcome emails have a link which signs the user in automatically
  before_create :ensure_authentication_token

  # did we use a temporary password when creating this user?
  before_validation :assign_temporary_password, :on => :create
  def assign_temporary_password
    self.password = self.temporary_password if self.temporary_password.present?
  end

  # if the email address is the DEVELOPER_EMAIL then make them the admin (very useful for the creation of the first user)
  before_validation {|record|
    record.admin = true if record.email == ENV['DEVELOPER_EMAIL']
  }

  # clean up/normalize the twitter handle
  before_validation {|record|
    # normalize the twitter name (some people enter @screenname and other just enter screenname - we strip the @)
    record.twitter_screen_name = record.twitter_screen_name[1..9999] if record.twitter_screen_name.present? && record.twitter_screen_name[0] == '@'

    # generate an availiable and sensible permalink (unless one already exists)
    #unless record.permalink.present?
    if not record.permalink.present? and name.present?
      permalink = name.gsub(' ', '_').gsub(/[^\w\d_]/, '').downcase
      # if it already exists, then add a number
      i = nil
      while User.find_by_permalink("#{permalink}#{i}").present?
        i = (i||0)+1
      end
      permalink = "#{permalink}#{i}"
      record.permalink = permalink
    end
  }

  # send out the welcome email
  after_create do |user|
    if !self.is_admin_created.present? || (self.is_admin_created.present? && !self.is_admin_created)
      begin
        ApplicationMailer.welcome(user).deliver unless Rails.env == 'test'
      rescue
      end
    end
  end

  validates :permalink, :presence => true, :uniqueness => true, :format => {:with => /^[\w\d_]+$/}
  #validate :validate_portrait_dimensions, :if => "portrait.present?", :unless => "errors.any?"
  #validate :validate_portrait2_dimensions, :if => "portrait2.present?", :unless => "errors.any?"

  # tell the dynamic form that we need to post to an iframe to accept the file upload
  # TODO:: find a more elegant solution to this problem, can we detect the use of has_attached_file?
  def accepts_file_upload?
    true
  end

  has_attached_file :portrait,
    :styles => {
      :tiny_thumb => "60x60",
      :thumb => "117x117",
      :medium => "234x234",
      :full => "468x468",
    },
    :convert_options => {
      :tiny_thumb => "-quality 70",
      :thumb => "-quality 70",
      :medium => "-quality 70",
      :full => "-quality 70",
    },
    :path => "portraits/:style/:id.:extension"

  has_attached_file :portrait2,
    :styles => {
      :tiny_thumb => "60x60#",
      :thumb => "117x117#",
      :medium => "234x234#",
      :full => "468x468#",
    },
    :convert_options => {
      :tiny_thumb => "-quality 70",
      :thumb => "-quality 70",
      :medium => "-quality 70",
      :full => "-quality 70",
    },
    :path => "alternative-portraits/:style/:id.:extension"

  # an array representing this users special permissiond (tags) used for display purposes
  def access_tags
    tags = []
    tags << 'admin' if admin?
    tags << 'speaker' if is_speaker?
    tags << 'staff' if staff?
    tags
  end

  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.underscore.downcase,
      :name => name,
      :title => title,
      :bio => bio,
      :twitter_screen_name => twitter_screen_name,
      :permalink => permalink,
      :photo => portrait.url
    }
  end

  def self.csv_columns   # class method
    ['Name', 'Email']
  end

  def csv_attributes
    [name, email]
  end

  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    case parent_model.class.name.underscore
    when 'foo'
    else
      [
        { :name => :search, :as => :string, :fields => [:email, :name], :wildcard => :both },
        { :name => :created_at, :as => :datetimerange },
        { :name => :staff, :field => :staff, :as => :boolean, :true_label => 'Yes', :false_label => 'No' },
        { :name => :admin, :field => :admin, :as => :boolean, :true_label => 'Yes', :false_label => 'No' },
        { :name => :speaker, :field => :speaker, :as => :boolean, :true_label => 'Yes', :false_label => 'No' },
      ]
    end
  end

  # we dont store the first name and last name seperately, so these convinience methods allow us to still use them
  def first_name
    name.split(' ').first
  end
  def last_name
    name.split(' ').last
  end

  # # has this user connected to facebook
  # def connected_to_facebook?
  #   fb_uid && fb_access_token
  # end

  # facebook profile picture
  # def facebook_profile_pic_src
  #   connected_to_facebook? ? "https://graph.facebook.com/#{fb_uid}/picture" : nil
  # end

  # has this user connected to twitter
  def connected_to_twitter?
    twitter_token && twitter_secret
  end

  # a string representation of the required dimensions for the portrait image
  def portrait1_dimensions_string
    "#{PORTRAIT1_WIDTH}x#{PORTRAIT1_HEIGHT}"
  end
  def portrait2_dimensions_string
    "#{PORTRAIT2_WIDTH}x#{PORTRAIT2_HEIGHT}"
  end

  # parses the description wih markdown and returns html
  def bio_html
    return nil unless bio.present?
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :no_links => true, :hard_wrap => true)
    markdown.render(bio).html_safe
  end

  def bio_abbreviated
    ( bio.present? && bio.length > 200 ) ? "#{bio[0..197]}..." : bio
  end

  def title_abbreviated
    ( title.present? && title.length > 75 ) ? "#{title[0..72]}..." : title
  end


  # Need to normalize the search attributes
  def search_attributes
    {:title => self.name, :description => self.bio.present? ? self.bio[0..100] : "", :image => self.portrait(:thumb)}
  end

  def top_role
    return 'admin' if admin
    return 'is_sponsor' if is_sponsor
    return 'is_speaker' if is_speaker
    return 'is_volunteer' if is_volunteer
    return 'is_member' if is_member
  end

  def create_simulate_user
    return nil unless self.admin?
    SimulateUser.create! email: self.email, user_id: self.id
  end

  def invitation_accepted?
    invitation_accepted_at.present?
  end

  after_save :create_role_association
  private

    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_portrait_dimensions
      if portrait.queued_for_write[:full]
        dimensions = Paperclip::Geometry.from_file(portrait.queued_for_write[:full].path)
        errors.add(:portrait, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{portrait1_dimensions_string}") unless dimensions.width == PORTRAIT1_WIDTH && dimensions.height == PORTRAIT1_HEIGHT
      end
    end

    # i know its strict, but otherwise people will upload images without appreciation for aspect ratio
    def validate_portrait2_dimensions
      if portrait2.queued_for_file[:full]
        dimensions = Paperclip::Geometry.from_file(portrait2.queued_for_file[:full].path)
        errors.add(:portrait2, "Image dimensions were #{dimensions.width.to_i}x#{dimensions.height.to_i}, they must be exactly #{portrait2_dimensions_string}") unless dimensions.width == PORTRAIT2_WIDTH && dimensions.height == PORTRAIT2_HEIGHT
      end
    end

    def create_role_association
      case top_role
      when 'is_speaker'
        self.speakers.create(year_id: DateTime.now.year) unless self.years.map(&:id).include?(DateTime.now.year)
      end
    end
end

