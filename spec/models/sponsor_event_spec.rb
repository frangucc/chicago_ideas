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

  describe '#order_by_month' do

    before do
      @sponsor_1 = FactoryGirl.create(:sponsor_event, :name => 'Sponsor', :month => 'July', :day => 'Late')
      @sponsor_2 = FactoryGirl.create(:sponsor_event, :name => 'Sponsor', :month => 'July', :day => '2')
      @sponsor_3 = FactoryGirl.create(:sponsor_event, :name => 'Sponsor', :month => 'July', :day => '21')
      @sponsor_4 = FactoryGirl.create(:sponsor_event, :name => 'Sponsor', :month => 'July', :day => 'Mid')
      @sponsor_5 = FactoryGirl.create(:sponsor_event, :name => 'Sponsor', :month => 'July', :day => '1')
      @sponsor_6 = FactoryGirl.create(:sponsor_event, :name => 'Sponsor', :month => 'July', :day => '12')
      @sponsor_7 = FactoryGirl.create(:sponsor_event, :name => 'Sponsor', :month => 'July', :day => '30')
      @sponsor_8 = FactoryGirl.create(:sponsor_event, :name => 'Sponsor', :month => 'August', :day => '30')
    end

    it 'returns mid, late, number order' do
      #debugger
      SponsorEvent.order_by_month('July').should == [@sponsor_1, @sponsor_4, @sponsor_5, @sponsor_2, @sponsor_6, @sponsor_3, @sponsor_7]
      SponsorEvent.order_by_month('August').should == [@sponsor_8]
    end

  end

end
