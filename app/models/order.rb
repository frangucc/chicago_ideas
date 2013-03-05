require 'authorize_net'
class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :member_type
  belongs_to :billing_address, foreign_key: :address_id, class_name: "Address"

  serialize :authnet_response

  accepts_nested_attributes_for :billing_address

  attr_accessor :email, :card_number, :expiry_date, :cvc, :amount

  validates_presence_of :name_on_card
  validates_presence_of :card_number
  validates_presence_of :amount

  validates :email, :email => true, :presence => true
  validates :expiry_date, :presence => true, :length => { :is => 4 }, :numericality => true
  validates :cvc, :presence => true, :length => { :is => 3 }, :numericality => true

  validate :amount_should_match_member_types, :email_available
  before_validation :assign_total_in_cents
  before_save :code_and_member, on: :create

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

  def email_available
    if User.exists?(email: self.email)
      errors.add(:email, "is taken")
    else
      true
    end
  end

  def process_transaction
    if self.valid?
      transaction = AuthorizeNet::AIM::Transaction.new(AUTHNET_LOGIN,
                                                       AUTHNET_KEY,
                                                       :gateway => AUTHNET_ENV)
      credit_card = AuthorizeNet::CreditCard.new(card_number, expiry_date)

      response = transaction.purchase(amount, credit_card)

      if response.success?

        # TODO: Serialize
        self.authnet_response = response
        save
        return true
      else
        errors.add(:base, "There was a problem processing your credit card.")
        return false
      end
    end
    false
  end

  protected
  def code_and_member
    while Order.find_by_code(self.code = SecureRandom.hex(4).upcase).present?; end
    self.create_user!(email: self.email, name: self.name_on_card, password: self.code)
  end
end
