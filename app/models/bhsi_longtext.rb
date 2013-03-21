class BhsiLongtext < ActiveRecord::Base

  include SearchSortPaginate

  MAX_ABOUT_YOURSELF_WORDS      = 400
  MAX_SOCIAL_VENTURE_DESC_WORDS = 250
  MAX_STRONG_MIDWEST_WORDS      = 300

  belongs_to :BhsiApplication

  validates :about_yourself, :presence => true, :length => {
    :maximum   => MAX_ABOUT_YOURSELF_WORDS,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :social_venture_description, :presence => true, :length => {
    :maximum   => MAX_SOCIAL_VENTURE_DESC_WORDS,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :strong_midwest_connections_explained, :length => {
    :maximum   => MAX_STRONG_MIDWEST_WORDS,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_long  => "must be less than %{count} words"
  }, :if => Proc.new { |bhsi| bhsi.strong_midwest_connections_explained.present? }

  validates :venture_launched,           :presence => true
  validates :number_people_affected,     :presence => true
  validates :explain_number,             :presence => true
  validates :organizational_development, :presence => true
  validates :three_standout_statistics,  :presence => true

end
