require "spec_helper"

describe OrderMailer do

  describe 'thank you membership mailer' do

    let(:order) { FactoryGirl.build(:order) }

    before(:each) do
      OrderMailer.thank_you_membership(order).deliver
      @email = ActionMailer::Base.deliveries.last
    end

    it 'should have proper headers' do
      @email.subject.should == "Thank you for joining CIW's Member Program"
      @email.from[0].should == 'forms@chicagoideas.com'
      @email.to[0].should   == order.email
    end

    it 'should have proper content' do
      @email.body.should match(/Thank you for joining CIW's Member Program/)
      @email.body.should match(/Hi, #{order.name_on_card}/)
      @email.body.should match(/Included in your #{order.member_type.title} package you receive/)
      order.member_type.try(:description).split("\r\n").reject { |i| i.empty? }.each do |line|
        @email.body.should match(/#{line}/)
      end
    end

  end

end
