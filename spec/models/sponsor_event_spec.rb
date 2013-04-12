require 'spec_helper'

describe SponsorEvent do

  let(:sponsor_event) { SponsorEvent.new }

  describe 'Validations' do

    [:month, :day, :name].each do |attribute|
      it "requires #{attribute}" do
        assert_presence sponsor_event, attribute
      end
    end

  end

end
