class Member < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  belongs_to :user
  belongs_to :member_type
  belongs_to :year

  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset

  delegate :email, :street_1, :city, :state, :zip, :phone, :to => :user
  delegate :title, :to => :member_type

  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.underscore.downcase,
      :user => user.api_attributes,
      :member_type => member_type.api_attributes,
      :first_name => first_name,
      :last_name => last_name,
    }
  end

  def get_first_name
    fname = (!first_name.nil? && first_name.strip.length > 0) ? first_name.strip : ''
    if fname.length == 0
      name = user.name
      idx = name.index(' ')
      if !idx.nil?
        fname = name[0..idx]
      end
    end
    return fname
  end

  def get_last_name
    lname = (!last_name.nil? && last_name.strip.length > 0) ? last_name.strip : ''
    if lname.length == 0
      name = user.name
      idx = name.index(' ')
      if !idx.nil?
        lname = name[(idx+1)..name.length]
      end
    end
    return lname
  end

  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    case parent_model.class.name.underscore
    when 'foo'
    else
      [
        { :name => :created_at, :as => :datetimerange },
      ]
    end
  end

  def full_name
    "#{ first_name } #{ last_name }"
  end

  def self.generate_current_year_members_excel
    CSV.open("/tmp/Member_list_#{Time.current.year}.csv", "wb", :col_sep => "\t") do |csv|
      csv << ["First Name", "Last Name", "Member Level", "Organization", "Contact Email", "Address", "City", "State", "Zip", "Phone"]
      Year.current_year_members.each do |member|
        csv << [member.first_name, member.last_name, member.title, member.email, member.street_1, member.city, member.state, member.zip, member.phone]
      end
    end
  end

end
