require 'spec_helper'

describe Order do

  let(:new_order) { Order.new }

  describe "Validations" do
    before do
      new_order.stub(:amount_should_match_member_types).and_return(true)
    end

    [:name_on_card, :card_number, :cvc, :member_type_id].each do |attribute|
      it "requires #{attribute}" do
        assert_presence new_order, attribute
      end
    end

    it 'requires amount to be a number' do
      new_order.amount = 'invalid'
      assert_numericality new_order, :amount
    end

    it 'requires cvc to be a number' do
      new_order.cvc = 'invalid'
      assert_numericality new_order, :cvc
    end

    it 'requires cvc to have proper length' do
      [2, 5].each do |cvc|
        new_order.cvc = cvc
        assert_numerical_range new_order, :cvc, 3
      end
    end
  end

end
