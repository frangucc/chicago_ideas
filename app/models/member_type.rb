class MemberType < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  validates :projected_members, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :maximum_members, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :min_price_in_cents, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :max_price_in_cents, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  has_many :members

  has_attached_file :image

  %w(min max).each do |str|
    # defines two setters:
    # min_price=
    # max_price=
    # this is used by formtastic

    price_setter = "#{str}_price=".to_sym
    define_method price_setter do |num|
      instance_variable_set("@#{str}_price", num)
    end


    # defines the accessors for the decimal price
    # min_price
    # max_price
    # we use this in the views
    # could be relpaced by a view helper
    price_getter = "#{str}_price".to_sym
    define_method price_getter do
      val = self.send("#{price_getter}_in_cents".to_sym)
      val / 100
    end

    # defines the callback that transforms the users input into an integer
    # set_min_price_in_cents
    # set_max_price_in_cents
    # rather metaprogrammed all in one block
    # than in two sepparate blocks

    db_col_name = "#{str}_price_in_cents".to_sym
    callback_name = "set_#{db_col_name}".to_sym
    define_method callback_name do
      orig_price_in_cents = send(db_col_name)
      sent_price_in_cents = instance_variable_get("@#{str}_price").to_i
      if sent_price_in_cents != (orig_price_in_cents / 100)
        send("#{db_col_name}=", sent_price_in_cents * 100)
      end
    end

    before_save callback_name
  end


  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.underscore.downcase,
      :name => name,
      :description => description
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

  def maximum_members_string
    return "unlimited" if maximum_members == 0
    maximum_members
  end

end
