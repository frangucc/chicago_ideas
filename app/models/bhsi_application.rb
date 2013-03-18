class BhsiApplication < ActiveRecord::Base

  include SearchSortPaginate
  include PdfCreator

  MAX_MAKES_SOCIAL_INNOVATION_WORDS = 100
  MAX_INSPIRATION_WORDS             = 300
  MAX_SUSTAINABITILITY_MODEL_WORDS  = 400
  MIN_IMPROVEMENTS_WORDS            = 100
  MAX_IMPROVEMENTS_WORDS            = 200
  MAX_DISTINGUISH_YOURSELF_WORDS    = 400
  MAX_MAJOR_SOURCES_INCOME_WORDS    = 100
  MAX_IMPACT_WORDS                  = 300
  MAX_OBSTACLES_NEEDS_WORDS         = 400

  has_attached_file :pdf,              :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :previous_budget,  :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :press_clipping_1, :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :press_clipping_2, :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :press_clipping_3, :path => "applications/bhsi/pdfs/:id/:filename"

  belongs_to :user
  has_one :bhsi_longtext, :dependent => :destroy
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset

  accepts_nested_attributes_for :bhsi_longtext

  validates :first_name,                :presence => true
  validates :last_name,                 :presence => true
  validates :address1,                  :presence => true
  validates :city,                      :presence => true
  validates :state,                     :presence => true
  validates :country,                   :presence => true
  validates :phone_number,              :presence => true
  validates :zipcode,                   :presence => true
  validates :email,                     :presence => true
  validates :gender,                    :presence => true
  validates :birthdate,                 :presence => true
  validates :title,                     :presence => true
  validates :social_venture_name,       :presence => true
  validates :legal_structure,           :presence => true
  validates :url,                       :presence => true
  validates :twitter_handle,            :presence => true
  validates :video_url,                 :presence => true
  validates :applied_before,            :presence => true
  validates :reference_1_name,          :presence => true
  validates :reference_1_relationship,  :presence => true
  validates :reference_1_phone,         :presence => true
  validates :reference_1_email,         :presence => true
  validates :reference_2_name,          :presence => true
  validates :reference_2_relationship,  :presence => true
  validates :reference_2_phone,         :presence => true
  validates :reference_2_email,         :presence => true
  validates :agreement_accepeted,       :acceptance => {:accept => true}
  validates :user_id,                   :presence => true
  # validates :org_founder,               :presence => true
  validates :total_budget_current_year, :presence => true
  validates :budget_previous_year,      :presence => true
  validates :budget_current_year,       :presence => true

  validates_attachment_presence :previous_budget,  :presence => true
  validates_attachment_presence :pdf, :presence => true

  validates_format_of :previous_budget_file_name,  :with => %r{\.pdf$}i, :message => "file must be in .pdf format"
  validates_format_of :press_clipping_1_file_name, :with => %r{\.pdf$}i, :message => "file must be in .pdf format", :if => Proc.new { |u| u.press_clipping_1.present? }
  validates_format_of :press_clipping_2_file_name, :with => %r{\.pdf$}i, :message => "file must be in .pdf format", :if => Proc.new { |u| u.press_clipping_1.present? }
  validates_format_of :press_clipping_3_file_name, :with => %r{\.pdf$}i, :message => "file must be in .pdf format", :if => Proc.new { |u| u.press_clipping_1.present? }

  validates_attachment_size :previous_budget,  :less_than => 4.megabytes
  validates_attachment_size :press_clipping_1, :less_than => 4.megabytes
  validates_attachment_size :press_clipping_2, :less_than => 4.megabytes
  validates_attachment_size :press_clipping_3, :less_than => 4.megabytes

  validates :makes_social_innovation, :presence => true, :length => {
    :maximum   => MAX_MAKES_SOCIAL_INNOVATION_WORDS,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :inspiration, :presence => true, :length => {
    :maximum   => MAX_INSPIRATION_WORDS,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :sustainability_model, :length => {
    :maximum   => MAX_SUSTAINABITILITY_MODEL_WORDS,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :improvements, :presence => true, :length => {
    :maximum   => MAX_IMPROVEMENTS_WORDS,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :distinguish_yourself, :length => {
    :maximum   => MAX_DISTINGUISH_YOURSELF_WORDS,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :major_sources_income, :presence => true, :length => {
    :maximum   => MAX_MAJOR_SOURCES_INCOME_WORDS,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :impact, :presence => true, :length => {
    :maximum   => MAX_IMPACT_WORDS,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :obstacles_needs, :presence => true, :length => {
    :maximum   => MAX_OBSTACLES_NEEDS_WORDS,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_long  => "must be less than %{count} words"
  }


  before_create :generate_application_pdf
  after_create :notify_staff, :notify_applicant

  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    case parent_model.class.name.underscore
    when 'foo'
    else
      [
        { :name => :search, :as => :string, :fields => [:first_name], :wildcard => :both },
        { :name => :created_at, :as => :datetimerange }
      ]
    end
  end

  def notify_applicant
    BhsiApplicationsMailer.delay.thank_you_application(self)
  end

  def notify_staff
    BhsiApplicationsMailer.delay.send_form(self)
  end

  def pdf_file_name
    pdf_name = "Bhsi_#{self.social_venture_name}.pdf"
    pdf_name.gsub!(' ', '')
    pdf_name.gsub!('/', '_')
    pdf_name
  end

  def generate_application_pdf
    # html_file = render_to_string(.pdf.haml', :layout => false)
    # kit = PDFKit.new(html_file, :page_size => 'Letter')
    # @bhsi_application.pdf = kit.to_file("#{Rails.root}/tmp/#{generate_pdf_name(@bhsi_application)}")

    self.pdf = create_pdf('bhsi_applications/_bhsi_application_pdf', nil, self.pdf_file_name)
  end

end
