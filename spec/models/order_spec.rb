require 'spec_helper'

describe Order do
  let(:new_order) { Order.new }
  describe "Validations" do
    before do
      new_order.stub(:amount_should_match_member_types).and_return(true)
    end
    [:name_on_card, :address, :city, :state, :card_number,
     :zip, :amount, :email, :expiry_date, :cvc].each do |attribute|
      it "requires #{attribute}" do
        assert_presence new_order, attribute
      end
    end

    it "requires an email" do
      assert_email new_order, :email
    end
  end
end