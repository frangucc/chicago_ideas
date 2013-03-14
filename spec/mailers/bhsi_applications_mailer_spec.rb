require 'spec_helper'

describe BhsiApplicationsMailer do

  let(:bhsi_app) { FactoryGirl.build(:bhsi_application) }

  describe '#thank_you_application' do

    before(:each) do
      BhsiApplicationsMailer.thank_you_application(bhsi_app).deliver
      @email = ActionMailer::Base.deliveries.last
    end

    it 'email has proper headers' do
      @email.subject.should == 'BHSI Application Form Submission'
      @email.from[0].should == 'bhsi_submissions@chicagoideas.com'
      @email.to[0].should   == bhsi_app.email
    end

    it 'email has proper content' do
      @email.body.should match(/Dear BHSI Fellowship Applicant,/)
      @email.body.should match(/Thank you very much for your interest in the Bluhm\/Helf and Social Innovation Fellowship @ Chicago Ideas Week\./)
      @email.body.should match(/We've received your application and look forward to reviewing with our judging committee\./)
      @email.body.should match(/Semi-finalists will be announced by July 22nd\. In the meantime, please contact info@bluhmhelfand\.com if you have any questions./)
    end

  end

end
