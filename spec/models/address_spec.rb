require 'spec_helper'

describe Address do

  let(:address) { Address.new }

  describe 'Validations' do

    [:street_1, :city, :zip, :country, :state, :phone].each do |attribute|
      it "requires #{attribute}" do
        assert_presence address, attribute
      end
    end

  end

end
