class Sponsor < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  belongs_to :sponsorship_level

  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  has_many :sponsor_users
  has_many :users, through: :sponsor_users

  validates :sponsorship_level_id, :presence => true
  validates :name, :presence => true, :uniqueness => true

  scope :by_name, order('name asc')
  scope :featured_sponsors, :conditions => { :featured => true }
  scope :by_sort, order('sort asc')

  accepts_nested_attributes_for :sponsor_users
  attr_accessible :eps_logo, :name, :description, :url, :featured, :sort,
  :ciw_talks_tickets, :labs_tickets, :vip_reception_tickets, :edison_talk_tickets, :concert_tickets,
  :menlo_passes, :sponsorship_amount, :sponsorship_level_id, :logo, :sponsor_agreement, :locked
  # when this model is created, set the sort order to the last in the current set (unless it was already set)
  before_validation {|record|
    return true if record.sort.present?
    record.sort = Sponsor.maximum(:sort).to_i + 1
  }

  # Sort the model records all at once
  def self.sort(ids)
    update_all(
      ['sort = FIND_IN_SET(id, ?)', ids.join(',')],
      { :id => ids }
    )
  end

  # tell the dynamic form that we need to post to an iframe to accept the file upload
  # TODO:: find a more elegant solution to this problem, can we detect the use of has_attached_file?
  def accepts_file_upload?
    true
  end

  has_attached_file :logo,
    :styles => {
      :full => "260x260",
    },
    :convert_options => {
        :full => "-quality 70",
    }

  has_attached_file :eps_logo
  has_attached_file :sponsor_agreement
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :name => name,
      :description => description,
      :sponsorship_level => sponsorship_level.api_attributes,
      :logo => logo,
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

  # parses the description wih markdown and returns html
  def description_html
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :no_links => true, :hard_wrap => true)
    markdown.render(description).html_safe
  end

  def primary_contact
    su = self.sponsor_users.where(primary_contact: true).first
    return su ? su.user : nil
  end

  def active?
    eps_logo_file_name.present? && logo_file_name.present?
  end

  def unlock!
    if !self.active? && self.locked?
      self.update_attribute(:locked, false)
    end
  end

end
