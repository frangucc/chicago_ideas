require 'spec_helper'

describe SponsorEvent do

  let(:sponsor_event) { SponsorEvent.new }

  describe 'Validations' do

    [:month, :day, :name].each do |attribute|
      it "requires #{attribute}" do
        assert_presence sponsor_event, attribute
      end
    end

    it 'requires valid month' do
      sponsor_event.month = 'invalid'
      sponsor_event.should be_invalid
      sponsor_event.errors[:month].join.should match(/is not a valid month/)

      SponsorEvent::MONTHS.each do |month|
        sponsor_event.month = month
        sponsor_event.should be_invalid
        sponsor_event.errors[:month].join.should be_empty
      end
    end

    it 'requires valid day' do
      sponsor_event.day = 'invalid'
      sponsor_event.should be_invalid
      sponsor_event.errors[:day].join.should match(/is not a valid day/)

      SponsorEvent::VALID_DAYS.each do |day|
        sponsor_event.day = day
        sponsor_event.should be_invalid
        sponsor_event.errors[:day].join.should be_empty
      end
    end

  end

end
