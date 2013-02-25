require 'authorize_net'
class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :member_type

  attr_accessor :name_on_card, :email, :address, :city, :state, :card_number,
                :expiry_date, :cvc, :zip, :amount


  validates_presence_of :name_on_card
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :card_number
  validates_presence_of :zip
  validates_presence_of :amount

  validates :email, :email => true, :presence => true
  validates :expiry_date, :presence => true, :length => { :is => 4 }, :numericality => true
  validates :cvc, :presence => true, :length => { :is => 3 }, :numericality => true

  validate :amount_should_match_member_types
  before_validation :assign_total_in_cents

  def assign_total_in_cents
    total_in_cents = amount.to_f * 100
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
      transaction = AuthorizeNet::AIM::Transaction.new(AUTHNET_LOGIN,
                                                       AUTHNET_KEY,
                                                       :gateway => AUTHNET_ENV)
      credit_card = AuthorizeNet::CreditCard.new(card_number, expiry_date)

      response = transaction.purchase(amount, credit_card)
      if response.success?
        # TODO: Serialize
        save
        return true
      else
        errors.add(:base, "There was a problem processing your credit card.")
        return false
      end
    end
    false
  end
end
