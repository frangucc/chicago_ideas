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

  def amount_should_match_member_types
    self.amount = member_type.has_fixed_price? ? member_type.min_price : amount.to_f
    if amount.to_f <= member_type.min_price || amount.to_f >= member_type.max_price
      errors.add(:amount, "Must be between #{ member_type.min_price } and #{ member_type.max_price }")
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
        order.total_in_cents = amount*100
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
