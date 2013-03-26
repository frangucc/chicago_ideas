require 'authorize_net'
class Order < ActiveRecord::Base
  belongs_to :user, :autosave => true
  belongs_to :member_type
  belongs_to :billing_address, foreign_key: :address_id, class_name: "Address", :autosave => true

  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :user

  attr_accessor :card_number, :expiry_date, :cvc, :amount

  validates_presence_of :name_on_card
  validates_presence_of :card_number
  validates_presence_of :amount

  validates :expiry_date, :presence => true, :length => { :is => 4 }, :numericality => true
  validates :cvc, :presence => true, :length => { :minimum => 3, :maximum => 4 }, :numericality => true
  validates :member_type_id, :presence => true

  before_validation :assign_total_in_cents
  after_validation :amount_should_match_member_types

  after_initialize :set_code

  def assign_total_in_cents
    self.total_in_cents = (amount.to_f * 100).to_i
  end

  def amount_should_match_member_types
    fixed_amount_expected = member_type.has_fixed_price?
    self.amount = fixed_amount_expected ? member_type.max_price.to_f : self.amount.to_f
    if amount < member_type.min_price || amount > member_type.max_price
      if fixed_amount_expected
        errors.add(:amount, "must be #{ member_type.max_price }")
      else
        errors.add(:amount, "must be between #{ member_type.min_price } and #{ member_type.max_price }")
      end
    end
  end

  def process_transaction
    if self.valid?
      transaction = AuthorizeNet::AIM::Transaction.new(AUTHNET_LOGIN, AUTHNET_KEY, :gateway => AUTHNET_ENV)
      @address    = build_authnet_address
      @customer   = build_authnet_customer
      @order      = build_authnet_order

      transaction.set_address(@address)
      transaction.set_customer(@customer)
      transaction.set_fields(:phone => user.phone, :invoice_num => self.code )

      credit_card = AuthorizeNet::CreditCard.new(card_number, expiry_date)

      response = transaction.purchase(amount, credit_card)

      if response.success?
        self.an_response_reason_text  = response.fields[:response_reason_text]
        self.an_authorization_code    = response.fields[:authorization_code]
        self.an_invoice_number        = response.fields[:invoice_number]
        self.an_account_number        = response.fields[:account_number]
        self.an_card_type             = response.fields[:card_type]
        save
        return true
      else
        errors.add(:base, "There was a problem processing your credit card.")
        return false
      end
    end
    false
  end

  def self.generate_members_stats_excel
    total_orders  = Year.total_orders_by_member_type_in_current_year
    total_amounts = Year.total_amount_orders_by_member_type_in_current_year

    CSV.open("/tmp/Member_stats_#{Time.current.year}.csv", "wb", :col_sep => "\t") do |csv|
      csv << ["Membership Level", "Total Members", "Total Amount in cents"]
      Year.current_year_member_types.each do |member_type|
        orders_count = total_orders[member_type.id] || 0
        orders_amount = total_amounts[member_type.id] || 0
        csv << [member_type.title, orders_count, orders_amount]
      end
    end
  end

  protected
  def set_code
    if new_record?
      while Order.find_by_code(self.code = SecureRandom.hex(4).upcase).present?; end
    end
  end

  def build_authnet_address
    AuthorizeNet::Address.new(:first_name  => user.first_name,
                              :last_name   => user.last_name,
                              :street_address => "#{ user.address.street_1 } #{ user.address.street_2 }",
                              :city        => user.address.city,
                              :state       => user.address.state,
                              :zip         => user.address.zip,
                              :phone       => user.phone)
  end

  def build_authnet_customer
    AuthorizeNet::Customer.new( :phone => user.phone,
                                :email => user.email,
                                :description => "#{ member_type.title } membership",
                                :address => @address)
  end

  def build_authnet_order
    AuthorizeNet::Order.new(:invoice_num => self.code, :description => "Order")
  end
end
