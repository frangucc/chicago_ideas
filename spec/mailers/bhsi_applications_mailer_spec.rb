require 'spec_helper'

describe BhsiApplicationsMailer do

  let(:bhsi_app) { FactoryGirl.build(:bhsi_application) }

  before do
    bhsi_app.pdf = bhsi_app.previous_budget = File.open("./spec/fixtures/blank.pdf")
    bhsi_app.stub(:notify_staff)
    bhsi_app.stub(:notify_applicant)
    bhsi_app.stub(:generate_application_pdf)

    bhsi_app.save
  end

  describe '#thank_you_application' do

    before do
      BhsiApplicationsMailer.thank_you_application(bhsi_app).deliver
      @email = ActionMailer::Base.deliveries.last
    end

    it 'sends proper headers' do
      @email.subject.should == 'BHSI Application Form Submission'
      @email.from[0].should == ApplicationHelper::CIW_BHSI_SUBM_EMAIL
      @email.to[0].should   == bhsi_app.email
    end

    it 'sends proper content' do
      @email.body.should match(/Dear BHSI Fellowship Applicant,/)
      @email.body.should match(/Thank you very much for your interest in the Bluhm\/Helf and Social Innovation Fellowship @ Chicago Ideas Week\./)
      @email.body.should match(/We've received your application and look forward to reviewing with our judging committee\./)
      @email.body.should match(/Semi-finalists will be announced by July 22nd\. In the meantime, please contact info@bluhmhelfand\.com if you have any questions./)
    end

  end

  describe "#send_form" do
    before do
      BhsiApplicationsMailer.send_form(bhsi_app).deliver
      @email = ActionMailer::Base.deliveries.last
    end

    it "sends proper headers" do
      @email.subject.should == 'BHSI Application Form Submission'
      @email.from[0].should == ApplicationHelper::CIW_BHSI_SUBM_EMAIL
      @email.to[0].should   == ApplicationHelper::BHSI_RECIPIENTS
    end
  end

end
