require 'spec_helper'

describe CooperativeMailer do

  let(:co_app) { FactoryGirl.build(:cooperative_application) }

  describe 'send form mail' do

    before(:each) do
      CooperativeMailer.send_form(co_app).deliver
      @email = ActionMailer::Base.deliveries.last
    end

    it 'should have proper headers' do
      @email.subject.should == 'Cooperative Application Form Submission'
      @email.from[0].should == 'kelly@chicagoideas.com'
      @email.to[0].should   == 'kelly@chicagoideas.com'
    end

    it 'should have proper content' do
      @email.body.should match(/Cooperative Application Information\./)
      @email.body.should have_link('Application', :href => admin_cooperative_application_url(co_app))
    end

  end

  describe 'thank you application mail' do

    before(:each) do
      CooperativeMailer.thank_you_application(co_app).deliver
      @email = ActionMailer::Base.deliveries.last
    end

    it 'should have proper headers' do
      @email.subject.should == 'Cooperative Application Form Submission'
      @email.from[0].should == 'kelly@chicagoideas.com'
      @email.to[0].should   == co_app.email
    end

    it 'should have proper content' do
      @email.body.should match(/We Just Want To Say Thank You\!/)
      @email.body.should match(/Hi, #{co_app.name},/)
      @email.body.should match(/Thanks for applying to the Co-op\! On behalf of everybody at CIW, we appreciate your interest and ethusiasm - we couldn't do this without you\!/)
      @email.body.should have_link('kelly@chicagoideas.com')
      @email.body.should match(/312-765-7819/)
    end

  end

end
