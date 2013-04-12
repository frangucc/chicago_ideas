require "spec_helper"

describe SponsorsMailer do

  let(:sponsor) { FactoryGirl.build(:sponsor) }

  describe '#notify_logos_upload' do

    before do
      SponsorsMailer.notify_logos_upload(sponsor).deliver
      @email = ActionMailer::Base.deliveries.last
    end

    it 'sends proper headers' do
      @email.subject.should == 'New logos uploaded for sponsor.'
      @email.from[0].should == 'forms@chicagoideas.com'
      @email.to[0].should   == 'sam@chicagoideas.com'
    end

    it 'sends proper content' do
      @email.body.should match(/The sponsor #{sponsor.name} has been modified and is currently inactive:/)
      @email.body.should match(/A sponsor user has uploaded new logos for it\./)
      @email.body.should match(/You can accept them or not/)
    end

  end

end
