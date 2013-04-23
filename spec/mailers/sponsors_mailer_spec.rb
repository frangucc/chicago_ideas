require "spec_helper"

describe SponsorsMailer do

  let(:user) { FactoryGirl.create(:user, :is_sponsor => true, :sponsor => FactoryGirl.create(:sponsor)) }

  describe '#notify_logos_upload' do

    before do
      user.sponsor_user.update_attributes(:eps_logo => File.open('./spec/fixtures/sponsor_logo.jpg'),
                                          :logo     => File.open('./spec/fixtures/sponsor_logo.jpg'))
      SponsorsMailer.notify_logos_upload(user.sponsor_user).deliver
      @email = ActionMailer::Base.deliveries.last
    end

    it 'sends proper headers' do
      @email.subject.should    == 'New logos uploaded for sponsor user.'
      @email.from[0].should    == 'forms@chicagoideas.com'
      @email.to.should         == ['user@domain.com']
    end

    it 'sends proper content' do
      @email.body.should match(/The sponsor user #{user.name} has uploaded his eps_logo and logo/)
    end

  end

end
