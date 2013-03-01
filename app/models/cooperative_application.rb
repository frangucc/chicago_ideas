class CooperativeApplication < ActiveRecord::Base

  include SearchSortPaginate

  MAX_WORKED_ON_WORDS       = 400
  MAX_PART_MEANINGFUL_WORDS = 200
  MAX_INS_FAILURE_WORDS     = 300
  MAX_NEIGHBORHOOD_WORDS    = 100

  validates :name,            presence: true
  validates :last_name,       presence: true
  validates :organization,    presence: true
  validates :phone,           presence: true
  validates :email,           presence: true, email: true
  validates :org_mission,     presence: true
  validates :org_website,     presence: true
  validates :org_twitter,     presence: true
  validates :reason,          presence: true
  validates :worked_on,       presence: true, length: { maximum: MAX_WORKED_ON_WORDS,       too_long: "You have exceeded the %{count} word count!", tokenizer: lambda { |str| str.scan(/\w+/) } }
  validates :part_meaningful, presence: true, length: { maximum: MAX_PART_MEANINGFUL_WORDS, too_long: "You have exceeded the %{count} word count!", tokenizer: lambda { |str| str.scan(/\w+/) } }
  validates :ins_failure,     presence: true, length: { maximum: MAX_INS_FAILURE_WORDS,     too_long: "You have exceeded the %{count} word count!", tokenizer: lambda { |str| str.scan(/\w+/) } }
  validates :neighborhood,    presence: true, length: { maximum: MAX_NEIGHBORHOOD_WORDS,    too_long: "You have exceeded the %{count} word count!", tokenizer: lambda { |str| str.scan(/\w+/) } }
  validates :assisted_area,   presence: true
  validates :recommend,       presence: true

  has_attached_file :pdf, :path => "applications/cooperative/pdfs/:id/:filename"

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

  def self.to_csv(co_op, options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      csv << co_op.attributes.values_at(*column_names)
    end
  end

end

