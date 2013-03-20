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
  BIRTHDATE_LIMIT                   = "10/13/1978"
  BIRTHDATE_FORMAT                  = "%m/%d/%Y"
  MAX_PDF_FILE_SIZE                 = 20

  has_attached_file :pdf,                   :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :previous_budget,       :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :current_budget,        :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :press_clipping_1,      :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :press_clipping_2,      :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :press_clipping_3,      :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :venture_standard_deck, :path => "applications/bhsi/pdfs/:id/:filename"

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
  validates :email,                     :presence => true, :email => true
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
  validates :reference_1_email,         :presence => true, :email => true
  validates :reference_2_name,          :presence => true
  validates :reference_2_relationship,  :presence => true
  validates :reference_2_phone,         :presence => true
  validates :reference_2_email,         :presence => true, :email => true
  validates :agreement_accepeted,       :acceptance => {:accept => true}
  validates :total_budget_current_year, :presence => true
  validates :org_founder,               :inclusion => { :in => [true, false] }, :allow_nil => false
  validates :org_join_point,            :presence => true
  validates :sustainability_model,      :presence => true

  validate :limit_birthdate, :if => Proc.new { |b| b.birthdate.present? }

  validates_attachment_presence :previous_budget
  validates_attachment_presence :current_budget
  validates_attachment_presence :venture_standard_deck

  validates_format_of :previous_budget_file_name,       :with => %r{\.pdf$}i, :message => "file must be in .pdf format"
  validates_format_of :current_budget_file_name,        :with => %r{\.pdf$}i, :message => "file must be in .pdf format"
  validates_format_of :press_clipping_1_file_name,      :with => %r{\.pdf$}i, :message => "file must be in .pdf format", :if => Proc.new { |u| u.press_clipping_1.present? }
  validates_format_of :press_clipping_2_file_name,      :with => %r{\.pdf$}i, :message => "file must be in .pdf format", :if => Proc.new { |u| u.press_clipping_2.present? }
  validates_format_of :press_clipping_3_file_name,      :with => %r{\.pdf$}i, :message => "file must be in .pdf format", :if => Proc.new { |u| u.press_clipping_3.present? }
  validates_format_of :venture_standard_deck_file_name, :with => %r{\.pdf$}i, :message => "file must be in .pdf format"

  validates_attachment_size :previous_budget,       :less_than => MAX_PDF_FILE_SIZE.megabytes
  validates_attachment_size :current_budget,        :less_than => MAX_PDF_FILE_SIZE.megabytes
  validates_attachment_size :press_clipping_1,      :less_than => MAX_PDF_FILE_SIZE.megabytes
  validates_attachment_size :press_clipping_2,      :less_than => MAX_PDF_FILE_SIZE.megabytes
  validates_attachment_size :press_clipping_3,      :less_than => MAX_PDF_FILE_SIZE.megabytes
  validates_attachment_size :venture_standard_deck, :less_than => MAX_PDF_FILE_SIZE.megabytes

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
  validates :sustainability_model, :presence => true, :length => {
    :maximum   => MAX_SUSTAINABITILITY_MODEL_WORDS,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :improvements, :presence => true, :length => {
    :maximum   => MAX_IMPROVEMENTS_WORDS,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :distinguish_yourself, :presence => true, :length => {
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


  attr_accessor :html2pdf

  before_create :generate_application_pdf
  after_create  :notify_applicant
  after_create  :notify_staff

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
    BhsiApplicationsMailer.delay.notify_applicant(self)
  end

  def notify_staff
    BhsiApplicationsMailer.delay.notify_staff(self)
  end

  def generate_application_pdf
    options = { name:             "bhsi_applications",
                document_type:    :pdf,
                test:             !Rails.env.production?,
                document_content: self.html2pdf }

    pdf = DocRaptor.create(options)

    friendlyName = "BHSI_APP_#{ self.social_venture_name}.pdf"
    File.open("/tmp/#{friendlyName}", 'w+b') { |f| f.write(pdf) }
    self.pdf = File.open("/tmp/#{friendlyName}")
  end

  private

  def limit_birthdate
    begin
      birth_date = Date.strptime(birthdate, BIRTHDATE_FORMAT)
      if  birth_date <= Date.strptime(BIRTHDATE_LIMIT, BIRTHDATE_FORMAT) || birth_date >= Date.current
        errors.add(:birthdate, "Must be greater than #{BIRTHDATE_LIMIT}.")
      end
    rescue
      errors.add(:birthdate, "Invalid birthdate format, should be mm/dd/yyyy.")
    end
  end

end
