require 'spec_helper'

describe Order do

  let(:new_order) { Order.new }

  describe "Validations" do
    before do
      new_order.stub(:amount_should_match_member_types).and_return(true)
    end

    [:name_on_card, :card_number, :amount, :expiry_date, :cvc, :member_type_id].each do |attribute|
      it "requires #{attribute}" do
        assert_presence new_order, attribute
      end
    end

    it 'requires expiry_date to be a number' do
      new_order.expiry_date = 'invalid'
      assert_numericality new_order, :expiry_date
    end

    it 'requires cvc to be a number' do
      new_order.cvc = 'invalid'
      assert_numericality new_order, :cvc
    end

    it 'requires expiry_date to have proper length' do
      [1, 12, 123].each do |exp_date|
        new_order.expiry_date = exp_date
        assert_numerical_range new_order, :expiry_date, 4
      end
    end

    it 'requires cvc to have proper length' do
      new_order.cvc = 2
      assert_numerical_range new_order, :cvc, 3

      new_order.cvc = 5
      assert_numerical_range new_order, :cvc, 3
    end
  end

end
