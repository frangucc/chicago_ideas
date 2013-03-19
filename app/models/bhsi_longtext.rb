class BhsiLongtext < ActiveRecord::Base

  include SearchSortPaginate

  MIN_ABOUT_YOURSELF_WORDS      = 100
  MAX_ABOUT_YOURSELF_WORDS      = 200
  MAX_SOCIAL_VENTURE_DESC_WORDS = 50
  MIN_STRONG_MIDWEST_WORDS      = 50
  MAX_STRONG_MIDWEST_WORDS      = 100

  belongs_to :BhsiApplication

  validates :about_yourself, :presence => true, :length => {
    :minimum   => MIN_ABOUT_YOURSELF_WORDS,
    :maximum   => MAX_ABOUT_YOURSELF_WORDS,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_short => "must be greater than %{count} words",
    :too_long  => "must be less than %{count} words"
  }
  validates :social_venture_description, :presence => true, :length => {
    :maximum   => MAX_SOCIAL_VENTURE_DESC_WORDS,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :strong_midwest_connections_explained, :length => {
    :minimum   => MIN_STRONG_MIDWEST_WORDS,
    :maximum   => MAX_STRONG_MIDWEST_WORDS,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_short => "must be greater than %{count} words",
    :too_long  => "must be less than %{count} words"
  }, :if => Proc.new { |bhsi| bhsi.strong_midwest_connections_explained.present? }
  validates :venture_launched,           :presence => true
  validates :number_people_affected,     :presence => true
  validates :explain_number,             :presence => true
  validates :organizational_development, :presence => true
  validates :three_standout_statistics,  :presence => true

end
